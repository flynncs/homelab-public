terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.111"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  api_token = var.proxmox_api_token
}

module "management" {
  source = "../../infra/modules/vm"

  name             = "management"
  description      = "example management VM"
  vm_id            = 200
  node             = "pve"
  bridge           = "vmbr0"
  datastore_vm     = "local-lvm"
  datastore_ci     = "local-lvm"
  template_id      = 9000
  cores            = 2
  memory_mb        = 2048
  disk_gb          = 20
  ci_user          = "admin"
  ci_password      = var.initial_password
  ssh_pub_key_path = var.ssh_pub_key_path
  ip               = "10.20.0.20"
  cidr             = "/24"
  gateway          = "10.20.0.1"
}

module "apps" {
  source = "../../infra/modules/lxc"

  name             = "apps"
  description      = "example application container"
  vm_id            = 201
  node             = "pve"
  bridge           = "vmbr0"
  datastore_ct     = "local-lvm"
  template_file_id = "local:vztmpl/debian-13-standard_13.0-1_amd64.tar.zst"
  cores            = 2
  memory_mb        = 2048
  disk_gb          = 16
  ci_password      = var.initial_password
  ssh_pub_key_path = var.ssh_pub_key_path
  ip               = "10.20.0.21"
  cidr             = "/24"
  gateway          = "10.20.0.1"
}
