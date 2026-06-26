locals {
  pool_name  = "default"
  nvram_path = "/var/lib/libvirt/qemu/nvram/${var.vm_name}.fd"
}

# Full clone disk: uploads local qcow2 into the pool
resource "libvirt_volume" "disk" {
  name = "${var.vm_name}.qcow2"
  pool = local.pool_name

  target = {
    format = { type = "qcow2" }
  }

  create = {
    content = {
      url = var.template_qcow2_path
    }
  }
}

# Cloud-init ISO is generated locally by the provider (mkisofs/genisoimage required)
resource "libvirt_cloudinit_disk" "cidata" {
  name = "${var.vm_name}-cidata"

  user_data = templatefile("${path.module}/cloud-init/user-data", {
    ansible_realname       = var.ansible_realname
    ansible_username       = var.ansible_username
    ansible_ssh_public_key = var.ansible_ssh_public_key
    hostname               = var.vm_name
    fqdn                   = "${var.vm_name}.example.local"
  })

  meta_data = templatefile("${path.module}/cloud-init/meta-data", {
    instance_id    = var.vm_name
    local_hostname = var.vm_name
  })

  network_config = templatefile("${path.module}/cloud-init/network-config", {
    ip      = var.vm_ip_address
    cidr    = var.vm_cidr
    gateway = var.vm_gateway
    dns1    = var.vm_dns1
    dns2    = var.vm_dns2
  })
}

# Upload the generated ISO into the pool as a libvirt volume
resource "libvirt_volume" "cidata_iso" {
  name = "${var.vm_name}-cidata.iso"
  pool = local.pool_name

  target = {
    format = { type = "iso" }
  }

  create = {
    content = {
      url = libvirt_cloudinit_disk.cidata.path
    }
  }
}

resource "libvirt_domain" "vm" {
  name        = var.vm_name
  memory      = 4096
  memory_unit = "MiB"
  vcpu        = 2
  type        = "kvm"
  running     = true
  autostart   = true

  cpu = {
    mode = "host-passthrough"
  }

  features = {
    acpi = true
  }

  os = {
    type            = "hvm"
    type_arch       = "x86_64"
    type_machine    = "q35"
    firmware        = "efi"
    loader          = "/usr/share/OVMF/OVMF_CODE_4M.fd"
    loader_readonly = "yes"
    loader_type     = "pflash"
    nv_ram = {
      nv_ram   = local.nvram_path
      template = "/usr/share/OVMF/OVMF_VARS_4M.fd"
    }
  }

  devices = {
    disks = [
      {
        driver = { type = "qcow2" }
        source = { file = { file = libvirt_volume.disk.path } }
        target = { dev = "vda", bus = "virtio" }
        boot   = { order = 1 }
      },
      {
        device = "cdrom"
        source = { file = { file = libvirt_volume.cidata_iso.path } }
        target = { dev = "sdb", bus = "sata" }
        # boot   = { order = 2 }
      }
    ]

    interfaces = [
      {
        model  = { type = "virtio" }
        source = { network = { network = "default", wait_for_lease = true } }
      }
    ]

    graphics = [
      {
        spice = {
          auto_port = true
          listen    = "127.0.0.1"
        }
      }
    ]

    video = [
      {
        model = {
          type = "virtio"
        }
      }
    ]

    # QEMU Guest Agent channel:
    channels = [
      {
        source = {
          unix = {
            # path = "/var/lib/libvirt/qemu/${self.name}.qga.sock"
          }
        }

        target = {
          virt_io = {
            name = "org.qemu.guest_agent.0"
          }
        }
      }
    ]
  }
}
