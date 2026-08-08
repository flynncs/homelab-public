locals {
  ci_password = var.initial_password

  # Single source of truth for VM/LXC identity — vm_id and IP both live here.
  hosts = {
    mgmt_vm     = { vm_id = 200, ip = "10.20.0.50" }
    apps_vm_1   = { vm_id = 201, ip = "10.20.0.51" }
    auth_vm_1   = { vm_id = 202, ip = "10.20.0.53" }
    jellyfin_ct = { vm_id = 203, ip = "10.20.0.40" }
    immich_ct   = { vm_id = 204, ip = "10.20.0.41" }
    edge_ct     = { vm_id = 205, ip = "10.20.0.42" }
    apps_ct     = { vm_id = 206, ip = "10.20.0.43" }
    adguard_ct  = { vm_id = 207, ip = "10.20.0.44" }
    rp_ct       = { vm_id = 208, ip = "10.20.0.45" }
  }
}

module "mgmt_vm" {
  source           = "./modules/vm"
  name             = "mgmt-vm"
  description      = "Komodo + Ansible controller"
  vm_id            = local.hosts.mgmt_vm.vm_id
  node             = var.node
  bridge           = var.bridge
  datastore_vm     = var.datastore_vm
  datastore_ci     = var.datastore_ci
  template_id      = var.template_id
  cores            = 2
  memory_mb        = 2048
  disk_gb          = 20
  ci_user          = var.ci_user
  ci_password      = local.ci_password
  ssh_pub_key_path = var.ssh_pub_key_path
  ip               = local.hosts.mgmt_vm.ip
  cidr             = var.cidr
  gateway          = var.gateway
}

module "apps_vm_1" {
  source           = "./modules/vm"
  name             = "apps-vm-1"
  description      = "Docker host for media automation and music services"
  vm_id            = local.hosts.apps_vm_1.vm_id
  node             = var.node
  bridge           = var.bridge
  datastore_vm     = var.datastore_vm
  datastore_ci     = var.datastore_ci
  template_id      = var.template_id
  cores            = 4
  memory_mb        = 8192
  disk_gb          = 80
  ci_user          = var.ci_user
  ci_password      = local.ci_password
  ssh_pub_key_path = var.ssh_pub_key_path
  ip               = local.hosts.apps_vm_1.ip
  cidr             = var.cidr
  gateway          = var.gateway
}

module "auth_vm_1" {
  source           = "./modules/vm"
  name             = "auth-vm-1"
  description      = "Identity stack — pocket-id, lldap, tinyauth"
  vm_id            = local.hosts.auth_vm_1.vm_id
  node             = var.node
  bridge           = var.bridge
  datastore_vm     = var.datastore_vm
  datastore_ci     = var.datastore_ci
  template_id      = var.template_id
  cores            = 2
  memory_mb        = 2048
  disk_gb          = 20
  ci_user          = var.ci_user
  ci_password      = local.ci_password
  ssh_pub_key_path = var.ssh_pub_key_path
  ip               = local.hosts.auth_vm_1.ip
  cidr             = var.cidr
  gateway          = var.gateway
}

module "edge_ct" {
  source           = "./modules/lxc"
  name             = "edge"
  description      = "Pangolin tunnel client — Docker host, Komodo-managed"
  vm_id            = local.hosts.edge_ct.vm_id
  node             = var.node
  bridge           = var.bridge
  datastore_ct     = var.datastore_vm
  template_file_id = var.ct_template_file_id
  os_type          = "debian"
  cores            = 1
  memory_mb        = 512
  disk_gb          = 8
  ci_user          = var.ci_user
  ci_password      = local.ci_password
  ssh_pub_key_path = var.ssh_pub_key_path
  ip               = local.hosts.edge_ct.ip
  cidr             = var.cidr
  gateway          = var.gateway
}

module "apps_ct" {
  source           = "./modules/lxc"
  name             = "apps"
  description      = "Docker host for smaller application stacks"
  vm_id            = local.hosts.apps_ct.vm_id
  node             = var.node
  bridge           = var.bridge
  datastore_ct     = var.datastore_vm
  template_file_id = var.ct_template_file_id
  os_type          = "debian"
  cores            = 2
  memory_mb        = 2048
  disk_gb          = 20
  ci_user          = var.ci_user
  ci_password      = local.ci_password
  ssh_pub_key_path = var.ssh_pub_key_path
  ip               = local.hosts.apps_ct.ip
  cidr             = var.cidr
  gateway          = var.gateway
}

module "adguard_ct" {
  source = "./modules/lxc"
  name   = "adguard"
  # Keep this Terraform resource address and guest name stable to avoid
  # recreating the DNS LXC during the application migration to Pi-hole.
  description      = "Pi-hole DNS — Docker host, Komodo-managed"
  vm_id            = local.hosts.adguard_ct.vm_id
  node             = var.node
  bridge           = var.bridge
  datastore_ct     = var.datastore_vm
  template_file_id = var.ct_template_file_id
  os_type          = "debian"
  cores            = 1
  memory_mb        = 512
  disk_gb          = 4
  ci_user          = var.ci_user
  ci_password      = local.ci_password
  ssh_pub_key_path = var.ssh_pub_key_path
  ip               = local.hosts.adguard_ct.ip
  cidr             = var.cidr
  gateway          = var.gateway
}

module "rp_ct" {
  source           = "./modules/lxc"
  name             = "rp"
  description      = "Caddy reverse proxy — Docker host, Komodo-managed"
  vm_id            = local.hosts.rp_ct.vm_id
  node             = var.node
  bridge           = var.bridge
  datastore_ct     = var.datastore_vm
  template_file_id = var.ct_template_file_id
  os_type          = "debian"
  cores            = 1
  memory_mb        = 512
  disk_gb          = 4
  ci_user          = var.ci_user
  ci_password      = local.ci_password
  ssh_pub_key_path = var.ssh_pub_key_path
  ip               = local.hosts.rp_ct.ip
  cidr             = var.cidr
  gateway          = var.gateway
}

module "jellyfin_ct" {
  source           = "./modules/lxc"
  name             = "jellyfin"
  description      = "Jellyfin and Navidrome — Docker host with iGPU passthrough"
  vm_id            = local.hosts.jellyfin_ct.vm_id
  node             = var.node
  bridge           = var.bridge
  datastore_ct     = var.datastore_vm
  template_file_id = var.ct_template_file_id
  os_type          = "debian"
  cores            = 4
  memory_mb        = 4096
  disk_gb          = 60
  ci_user          = var.ci_user
  ci_password      = local.ci_password
  ssh_pub_key_path = var.ssh_pub_key_path
  ip               = local.hosts.jellyfin_ct.ip
  cidr             = var.cidr
  gateway          = var.gateway

  enable_gpu = true
  gpu_devices = [
    { path = "/dev/dri/card0", uid = 0, gid = 44 },
    { path = "/dev/dri/renderD128", uid = 0, gid = 105 },
  ]

  enable_mountpoint = true
  mountpoint_source = "/srv/storage/media"
  mountpoint_target = "/mnt/media"
}

module "immich_ct" {
  source           = "./modules/lxc"
  name             = "immich"
  description      = "Immich LXC with iGPU passthrough"
  vm_id            = local.hosts.immich_ct.vm_id
  node             = var.node
  bridge           = var.bridge
  datastore_ct     = var.datastore_vm
  template_file_id = var.ct_template_file_id
  os_type          = "debian"
  cores            = 2
  memory_mb        = 6144
  disk_gb          = 20
  ci_user          = var.ci_user
  ci_password      = local.ci_password
  ssh_pub_key_path = var.ssh_pub_key_path
  ip               = local.hosts.immich_ct.ip
  cidr             = var.cidr
  gateway          = var.gateway

  enable_gpu = true
  gpu_devices = [
    { path = "/dev/dri/card0", uid = 0, gid = 44 },
    { path = "/dev/dri/renderD128", uid = 0, gid = 105 },
  ]

  enable_mountpoint = true
  mountpoint_source = "/srv/storage/photos"
  mountpoint_target = "/mnt/photos"
}

output "ips" {
  value = {
    for name, h in local.hosts : name => h.ip
  }
}
