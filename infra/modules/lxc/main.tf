resource "proxmox_virtual_environment_container" "ct" {
  node_name   = var.node
  description = var.description
  vm_id       = var.vm_id
  operating_system {
    type             = var.os_type
    template_file_id = var.template_file_id
  }

  cpu {
    cores = var.cores
  }

  memory {
    dedicated = var.memory_mb
  }

  disk {
    datastore_id = var.datastore_ct
    size         = var.disk_gb
  }

  network_interface {
    name   = "eth0"
    bridge = var.bridge
  }

  unprivileged = false

  features {
    nesting = true
    keyctl  = true
  }

  initialization {
    hostname = var.name

    user_account {
      password = var.ci_password
      keys     = [file(var.ssh_pub_key_path)]
    }
    ip_config {
      ipv4 {
        address = "${var.ip}${var.cidr}"
        gateway = var.gateway
      }
    }
    dns {
      servers = ["1.1.1.1", "8.8.8.8"]
    }
  }

  dynamic "device_passthrough" {
    for_each = var.enable_gpu ? var.gpu_devices : []
    content {
      path = device_passthrough.value.path
      uid  = device_passthrough.value.uid
      gid  = device_passthrough.value.gid
      mode = device_passthrough.value.mode
    }
  }

  dynamic "mount_point" {
    for_each = var.enable_mountpoint ? [1] : []
    content {
      volume = var.mountpoint_source
      path   = var.mountpoint_target
      backup = false
    }
  }

  # password and template_file_id are provisioning-time only — Proxmox doesn't
  # apply cloud-init changes to running containers; template is a one-shot clone source.
  lifecycle {
    ignore_changes = [
      initialization[0].user_account[0].password,
      initialization[0].user_account[0].keys,
      operating_system[0].template_file_id,
    ]
  }
}

output "ip" {
  value = var.ip
}
