#cloud-config
autoinstall:
  version: 1

  locale: en_US.UTF-8
  timezone: Europe/Stockholm

  keyboard:
    layout: se
    variant: ""

  storage:
    layout:
      name: direct

  updates: all

  packages:
    - qemu-guest-agent
    - openssh-server

  ssh:
    install-server: true
    allow-pw: true

  identity:
    realname: "${realname}"
    username: "${username}"
    password: "${password_hash}"
    hostname: "${hostname}"

  late-commands:
    - curtin in-target --target=/target -- bash -c 'echo "${username}:${password}" | chpasswd'
    - curtin in-target --target=/target -- usermod -aG sudo ${username}
    - curtin in-target --target=/target -- bash -c 'echo "${username} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/99-${username}'
    - curtin in-target --target=/target -- chmod 0440 /etc/sudoers.d/99-${username}
    - curtin in-target --target=/target -- systemctl enable qemu-guest-agent
    - curtin in-target --target=/target -- systemctl enable ssh
