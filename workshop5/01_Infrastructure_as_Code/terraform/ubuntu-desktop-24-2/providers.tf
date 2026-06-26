terraform {
  required_version = ">= 1.5.0"
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "= 0.9.3"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}