variable "proxmox_api_url" {
  description = "Proxmox API endpoint"
  type        = string
  default     = "https://10.20.0.1:8006/api2/json"
}

variable "proxmox_api_token" {
  description = "Proxmox API token in user@realm!token=secret format"
  type        = string
  sensitive   = true
}

variable "initial_password" {
  description = "Initial VM and LXC password"
  type        = string
  sensitive   = true
}
# ---- Proxmox environment defaults ----
variable "node" {
  description = "Proxmox node name"
  default     = "pve"
}
variable "bridge" {
  description = "Linux bridge for VMs"
  default     = "vmbr0"
}
variable "datastore_vm" {
  description = "Storage for VM disks"
  default     = "local"
}
variable "datastore_ci" {
  description = "Storage for cloud-init"
  default     = "local"
}

# ---- Network ----
variable "gateway" {
  description = "Default gateway"
  default     = "10.20.0.1"
}
variable "cidr" {
  description = "CIDR suffix for static IPs"
  default     = "/24"
}

# ---- Template & access ----
variable "template_id" {
  description = "VMID of the cloud-init template"
  type        = number
  default     = 9000
}
variable "ssh_pub_key_path" {
  description = "Path to SSH public key to inject via cloud-init"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}
variable "ci_user" {
  description = "Initial cloud-init user (non-root)"
  type        = string
  default     = "admin"
}

variable "ct_template_file_id" {
  description = "LXC OS template (e.g. local:vztmpl/debian-12.tar.zst)"
  type        = string
  default     = "local:vztmpl/debian-12-standard_12.12-1_amd64.tar.zst"
}

variable "nfs_server" {
  type    = string
  default = "10.20.0.1"
}

variable "nfs_path" {
  type    = string
  default = "/srv/storage"
}

variable "nfs_mountpoint" {
  type    = string
  default = "/mnt/data"
}
