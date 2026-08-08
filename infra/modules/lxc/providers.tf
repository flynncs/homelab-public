terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      # version can be omitted here; it inherits from root
    }
  }
}
