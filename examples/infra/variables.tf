variable "proxmox_endpoint" {
  type    = string
  default = "https://pve.home.example:8006/api2/json"
}

variable "proxmox_api_token" {
  type      = string
  sensitive = true
}

variable "initial_password" {
  type      = string
  sensitive = true
}

variable "ssh_pub_key_path" {
  type    = string
  default = "~/.ssh/id_ed25519.pub"
}
