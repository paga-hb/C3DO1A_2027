variable "iso_url" {
  type        = string
  description = "ISO to create a template from"
  # default     = "https://releases.ubuntu.com/noble/ubuntu-24.04.4-desktop-amd64.iso"
  default     = "iso/ubuntu-24.04.4-desktop-amd64.iso"
}

variable "iso_checksum" {
  type        = string
  description = "SHA256 checksum for the ISO (format: sha256:<hex>)"
  # Checksum found here: https://releases.ubuntu.com/noble/SHA256SUMS
  default = "sha256:3a4c9877b483ab46d7c3fbe165a0db275e1ae3cfe56a5657e5a47c2f99a99d1e"
}

variable "vm_hostname" {
  type        = string
  description = "The VM template's hostname"
  default     = "ubuntu-desktop-24-template"
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