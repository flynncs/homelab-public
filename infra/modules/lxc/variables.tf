variable "name" {}
variable "description" { default = "" }
variable "vm_id" { type = number }

variable "node" {}
variable "bridge" {}

variable "datastore_ct" {
  description = "Datastore for container rootfs (e.g. local-lvm)"
}

variable "template_file_id" {
  description = "LXC OS template (e.g. local:vztmpl/debian-12.tar.zst)"
}

variable "os_type" {
  description = "debian, ubuntu, etc"
}

variable "cores" { type = number }
variable "memory_mb" { type = number }
variable "disk_gb" { type = number }

variable "ci_user" {}
variable "ci_password" { sensitive = true }
variable "ssh_pub_key_path" {}

variable "ip" {}
variable "cidr" {}
variable "gateway" {}

variable "enable_gpu" {
  type    = bool
  default = false
}

variable "gpu_devices" {
  description = "GPU devices to pass through. path is required; uid/gid/mode are optional (null = provider default)."
  type = list(object({
    path = string
    uid  = optional(number)
    gid  = optional(number)
    mode = optional(string)
  }))
  default = []
}

variable "enable_mountpoint" {
  type    = bool
  default = false
}

variable "mountpoint_target" {
  type    = string
  default = ""
}

variable "mountpoint_source" {
  type    = string
  default = ""
}
