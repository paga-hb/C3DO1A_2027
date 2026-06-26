variable "iso_url" {
  type        = string
  description = "ISO to create a template from"
  # default     = "https://releases.ubuntu.com/noble/ubuntu-24.04.4-live-server-amd64.iso"
  default = "iso/ubuntu-24.04.4-live-server-amd64.iso"
}

variable "iso_checksum" {
  type        = string
  description = "SHA256 checksum for the ISO (format: sha256:<hex>)"
  # Checksum found here: https://releases.ubuntu.com/noble/SHA256SUMS
  default = "sha256:e907d92eeec9df64163a7e454cbc8d7755e8ddc7ed42f99dbc80c40f1a138433"
}

variable "vm_hostname" {
  type        = string
  description = "The VM template's hostname"
  default     = "ubuntu-server-24-template"
}

variable "vm_realname" {
  type        = string
  description = "The default user's name inside the VM"
  default     = "Student"
}

variable "vm_username" {
  type        = string
  description = "The default user's username inside the VM"
  default     = "student"
}

variable "vm_password" {
  type        = string
  description = "The default user's password inside the VM"
  sensitive   = true
}

# IMPORTANT! Generate a SHA-512 hashed password with: openssl passwd -6
variable "vm_password_hash" {
  type        = string
  description = "The default user's password hash inside the VM"
  sensitive   = true
}