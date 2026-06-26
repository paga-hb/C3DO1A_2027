source "qemu" "ubuntu_desktop_24" {
  accelerator      = "kvm"
  cpus             = 2
  memory           = 4096
  disk_size        = "30000M"
  format           = "qcow2"
  output_directory = "template"
  vm_name          = "ubuntu-desktop-24-template.qcow2"
  headless         = false

  iso_url      = var.iso_url
  iso_checksum = var.iso_checksum

  # http_directory = "http"
  http_content = {
    "/user-data" = templatefile("${path.root}/http/user-data.pkrtpl.hcl", {
      realname       = var.vm_realname
      username       = var.vm_username
      password       = var.vm_password
      password_hash  = var.vm_password_hash
      hostname       = var.vm_hostname
    })

    "/meta-data" = templatefile("${path.root}/http/meta-data.pkrtpl.hcl", {
      instance_id    = var.vm_hostname
      local_hostname = var.vm_hostname
    })
  }

  # Using UEFI (to use BIOS, you would remove these 4 lines).
  firmware = "efi"
  efi_boot = true
  efi_firmware_code = "/usr/share/OVMF/OVMF_CODE_4M.fd"
  efi_firmware_vars = "/usr/share/OVMF/OVMF_VARS_4M.fd"

  # The desktop ISO uses GRUB. This “edits the boot entry” and appends autoinstall.
  boot_wait = "5s"
  boot_command = [
    "<esc><wait>",
    "e<wait>",
    "<down><down><down><end>",
    " autoinstall \"ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/\"",
    "<f10><wait>"
  ]

  ssh_username = var.vm_username
  # This is the plain-text password set by autoinstall (see user-data).
  ssh_password = var.vm_password
  ssh_timeout  = "45m"

  shutdown_command = "echo '${var.vm_username}' | sudo -S shutdown -P now"
}

build {
  sources = ["source.qemu.ubuntu_desktop_24"]

  provisioner "shell" {
    inline_shebang = "/bin/bash"
    inline = [
      "set -euxo pipefail",
      # Make template “clone-friendly”
      "sudo truncate -s 0 /etc/machine-id || true",
      "sudo rm -f /var/lib/dbus/machine-id || true",
      "sudo ln -sf /etc/machine-id /var/lib/dbus/machine-id || true",
      "sudo cloud-init clean --logs || true"
    ]
  }
}
