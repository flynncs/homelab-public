resource "proxmox_virtual_environment_vm" "vm" {
  name        = var.name
  node_name   = var.node
  description = var.description
  vm_id       = var.vm_id

  clone {
    vm_id = var.template_id
    full  = true
  }

  cpu {
    type    = "host"
    sockets = 1
    cores   = var.cores
  }

  memory { dedicated = var.memory_mb }

  disk {
    interface    = "scsi0"
    datastore_id = var.datastore_vm
    size         = var.disk_gb
  }

  network_device {
    model  = "virtio"
    bridge = var.bridge
  }

  agent { enabled = true }

  initialization {
    datastore_id = var.datastore_ci

    user_account {
      username = var.ci_user
      password = var.ci_password
      keys     = [trimspace(file(var.ssh_pub_key_path))]
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
}

output "ip" {
  value = var.ip
}

output "ips_reported" {
  value = var.ip
}
