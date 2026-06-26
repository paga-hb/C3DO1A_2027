variable "vm_name" {
  type        = string
  description = "Name of the VM clone"
  default     = "u24s02"
}

variable "vm_ip_address" {
  type        = string
  description = "VM IP address"
  default     = "192.168.122.98"
}

variable "vm_cidr" {
  type        = string
  description = "VM CIDR"
  default     = "24"
}

variable "vm_gateway" {
  type        = string
  description = "VM Gateway"
  default     = "192.168.122.1"
}

variable "vm_dns1" {
  type        = string
  description = "VM nameserver 1"
  default     = "192.168.122.1"
}

variable "vm_dns2" {
  type        = string
  description = "VM nameserver 2"
  default     = "8.8.8.8"
}

variable "template_qcow2_path" {
  type        = string
  description = "Path to the VM template (qcow2 from Packer)"
  default     = "../../packer/ubuntu-server-24/template/ubuntu-server-24-template.qcow2"
}

variable "ansible_realname" {
  type        = string
  description = "Full name for the ansible user"
  default     = "Ansible"
}

variable "ansible_username" {
  type        = string
  description = "User name for the ansible user"
  default     = "ansible"
}

variable "ansible_ssh_public_key" {
  type        = string
  description = "SSH public key for the ansible user"
  sensitive   = true
}