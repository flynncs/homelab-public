variable "name" {}
variable "description" { default = "" }
variable "vm_id" { type = number }

variable "node" {}
variable "bridge" {}
variable "datastore_vm" {}
variable "datastore_ci" {}
variable "template_id" { type = number }

variable "cores" { type = number }
variable "memory_mb" { type = number }
variable "disk_gb" { type = number }

variable "ci_user" {}
variable "ci_password" { sensitive = true }
variable "ssh_pub_key_path" {}

variable "ip" {}
variable "cidr" {}
variable "gateway" {}
