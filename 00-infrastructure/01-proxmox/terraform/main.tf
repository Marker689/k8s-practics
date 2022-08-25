terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
#      version = "2.9.11"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://pve.kharitonov.su/api2/json"
  pm_user = "terraform-prov@pve"
  pm_password = "password"
  pm_parallel = 3
  pm_timeout = 1000
}

resource "proxmox_vm_qemu" "cloudinit-node1" {
  ci_wait = 1
  name = "node1"
  vmid = 2001
  target_node = "pve"
  clone = "ubuntu-cloudinit"
  cores = 12
  cpu = "host"
  memory = 4096
  agent = 1
  os_type = "cloud-init"
  ipconfig0 = "ip=192.168.103.11/24,gw=192.168.103.1"
  nameserver = "192.168.1.1"
  searchdomain = "lan"
  ciuser = "marker"
  sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9GFE90/EPwYsLkJ21g8imK1465UFvvnyhkdHSWF5YfhuGxyNYE2uID7aIyr16HTXZyKIIqb0aNs9BYzYhwi+NCMVtmSyWXlBtBkBF7A53ErB8KQoy7YlYjPGyMnJYUhzxddSf6/s2P8ljeXow370hR5pTcG1mdfoG9+OcZLT1RESFDxyxgbNRS/dx1kMdnz/SY1/QPfnJzzbAmixcePxaNdOWoAG9Wl3TXzlCUUDTaz2LHl5La4tBm+IiatW5Ubaw+1YMX/3fmMuXalpqc5uO/wX1kS35DMXW9FYFLC+7vxKb0rzoXXsgaipTRG6OWMjvat8WjjD4RRVrEb2b+gGovnoND8+nakIGcW+LmTUZZ7QPjMoEdS0G64xleueEplHIMVq+cu10WCivACM75Ewl/pnnOH1sHAbbJhOcbFH4y0oUYifnbyNbe2rwCletPzcG/Gg2/bbd0HskoY76DqBQF+9chp7GJ7NVFund7xYoTaloUYAgywmB1XRUKczmtQM= root@ControL
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQClDZ6tdafmh+7GQnYHPqDTTV2bp8yw2tJl6XU5eu7hjLCGms8Id+h5LevqrL1KgG0kIEa7Zq52L9WHQ/uA8YenFoxWImEiUw1EaSenrWIVzLigEc7xN7kWaz3isZdCpVPBmwnEVDNHJDteMfJXNTULORGHqa+mBph/khcFxvvirjp+5+dn/Igxy6bgIGIaYMjvlJ7rNJ1+hxak96WyDVe5FcYFSyYn0vNy+In83LF8s0arXh3/gmH4HFMUiQUdoeD5fnvCfSFB2Oc7AFelJh0X9x3LlzOmcoBqRSiUa/tQpgBugSIVzTM2LAnMmpUX2cYs+Abv8wHU0tGodtyTpMS/ my.local
  EOF
  network {
    model = "virtio"
    bridge = "vmbr0"
    tag = 3
  }
  disk {
    type = "scsi"
    storage = "zfsimage"
    size = "32G"
  }
}

resource "proxmox_vm_qemu" "cloudinit-node2" {
  ci_wait = 1
  name = "node2"
  vmid = 2002
  target_node = "pve"
  clone = "ubuntu-cloudinit"
  cores = 12
  cpu = "host"
  memory = 4096
  agent = 1
  os_type = "cloud-init"
  ipconfig0 = "ip=192.168.103.12/24,gw=192.168.103.1"
  nameserver = "192.168.1.1"
  searchdomain = "lan"
  ciuser = "marker"
  sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9GFE90/EPwYsLkJ21g8imK1465UFvvnyhkdHSWF5YfhuGxyNYE2uID7aIyr16HTXZyKIIqb0aNs9BYzYhwi+NCMVtmSyWXlBtBkBF7A53ErB8KQoy7YlYjPGyMnJYUhzxddSf6/s2P8ljeXow370hR5pTcG1mdfoG9+OcZLT1RESFDxyxgbNRS/dx1kMdnz/SY1/QPfnJzzbAmixcePxaNdOWoAG9Wl3TXzlCUUDTaz2LHl5La4tBm+IiatW5Ubaw+1YMX/3fmMuXalpqc5uO/wX1kS35DMXW9FYFLC+7vxKb0rzoXXsgaipTRG6OWMjvat8WjjD4RRVrEb2b+gGovnoND8+nakIGcW+LmTUZZ7QPjMoEdS0G64xleueEplHIMVq+cu10WCivACM75Ewl/pnnOH1sHAbbJhOcbFH4y0oUYifnbyNbe2rwCletPzcG/Gg2/bbd0HskoY76DqBQF+9chp7GJ7NVFund7xYoTaloUYAgywmB1XRUKczmtQM= root@ControL
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQClDZ6tdafmh+7GQnYHPqDTTV2bp8yw2tJl6XU5eu7hjLCGms8Id+h5LevqrL1KgG0kIEa7Zq52L9WHQ/uA8YenFoxWImEiUw1EaSenrWIVzLigEc7xN7kWaz3isZdCpVPBmwnEVDNHJDteMfJXNTULORGHqa+mBph/khcFxvvirjp+5+dn/Igxy6bgIGIaYMjvlJ7rNJ1+hxak96WyDVe5FcYFSyYn0vNy+In83LF8s0arXh3/gmH4HFMUiQUdoeD5fnvCfSFB2Oc7AFelJh0X9x3LlzOmcoBqRSiUa/tQpgBugSIVzTM2LAnMmpUX2cYs+Abv8wHU0tGodtyTpMS/ my.local
  EOF
  network {
    model = "virtio"
    bridge = "vmbr0"
    tag = 3
  }
  disk {
    type = "scsi"
    storage = "zfsimage"
    size = "32G"
  }
}

resource "proxmox_vm_qemu" "cloudinit-node3" {
  ci_wait = 1
  name = "node3"
  vmid = 2003
  target_node = "pve"
  clone = "ubuntu-cloudinit"
  cores = 12
  cpu = "host"
  memory = 4096
  agent = 1
  os_type = "cloud-init"
  ipconfig0 = "ip=192.168.103.13/24,gw=192.168.103.1"
  nameserver = "192.168.1.1"
  searchdomain = "lan"
  ciuser = "marker"
  sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9GFE90/EPwYsLkJ21g8imK1465UFvvnyhkdHSWF5YfhuGxyNYE2uID7aIyr16HTXZyKIIqb0aNs9BYzYhwi+NCMVtmSyWXlBtBkBF7A53ErB8KQoy7YlYjPGyMnJYUhzxddSf6/s2P8ljeXow370hR5pTcG1mdfoG9+OcZLT1RESFDxyxgbNRS/dx1kMdnz/SY1/QPfnJzzbAmixcePxaNdOWoAG9Wl3TXzlCUUDTaz2LHl5La4tBm+IiatW5Ubaw+1YMX/3fmMuXalpqc5uO/wX1kS35DMXW9FYFLC+7vxKb0rzoXXsgaipTRG6OWMjvat8WjjD4RRVrEb2b+gGovnoND8+nakIGcW+LmTUZZ7QPjMoEdS0G64xleueEplHIMVq+cu10WCivACM75Ewl/pnnOH1sHAbbJhOcbFH4y0oUYifnbyNbe2rwCletPzcG/Gg2/bbd0HskoY76DqBQF+9chp7GJ7NVFund7xYoTaloUYAgywmB1XRUKczmtQM= root@ControL
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQClDZ6tdafmh+7GQnYHPqDTTV2bp8yw2tJl6XU5eu7hjLCGms8Id+h5LevqrL1KgG0kIEa7Zq52L9WHQ/uA8YenFoxWImEiUw1EaSenrWIVzLigEc7xN7kWaz3isZdCpVPBmwnEVDNHJDteMfJXNTULORGHqa+mBph/khcFxvvirjp+5+dn/Igxy6bgIGIaYMjvlJ7rNJ1+hxak96WyDVe5FcYFSyYn0vNy+In83LF8s0arXh3/gmH4HFMUiQUdoeD5fnvCfSFB2Oc7AFelJh0X9x3LlzOmcoBqRSiUa/tQpgBugSIVzTM2LAnMmpUX2cYs+Abv8wHU0tGodtyTpMS/ my.local
  EOF
  network {
    model = "virtio"
    bridge = "vmbr0"
    tag = 3
  }
  disk {
    type = "scsi"
    storage = "zfsimage"
    size = "32G"
  }
}

resource "proxmox_vm_qemu" "cloudinit-node4" {
  ci_wait = 1
  name = "node4"
  vmid = 2004
  target_node = "pve"
  clone = "ubuntu-cloudinit"
  cores = 12
  cpu = "host"
  memory = 4096
  agent = 1
  os_type = "cloud-init"
  ipconfig0 = "ip=192.168.103.14/24,gw=192.168.103.1"
  nameserver = "192.168.1.1"
  searchdomain = "lan"
  ciuser = "marker"
  sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9GFE90/EPwYsLkJ21g8imK1465UFvvnyhkdHSWF5YfhuGxyNYE2uID7aIyr16HTXZyKIIqb0aNs9BYzYhwi+NCMVtmSyWXlBtBkBF7A53ErB8KQoy7YlYjPGyMnJYUhzxddSf6/s2P8ljeXow370hR5pTcG1mdfoG9+OcZLT1RESFDxyxgbNRS/dx1kMdnz/SY1/QPfnJzzbAmixcePxaNdOWoAG9Wl3TXzlCUUDTaz2LHl5La4tBm+IiatW5Ubaw+1YMX/3fmMuXalpqc5uO/wX1kS35DMXW9FYFLC+7vxKb0rzoXXsgaipTRG6OWMjvat8WjjD4RRVrEb2b+gGovnoND8+nakIGcW+LmTUZZ7QPjMoEdS0G64xleueEplHIMVq+cu10WCivACM75Ewl/pnnOH1sHAbbJhOcbFH4y0oUYifnbyNbe2rwCletPzcG/Gg2/bbd0HskoY76DqBQF+9chp7GJ7NVFund7xYoTaloUYAgywmB1XRUKczmtQM= root@ControL
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQClDZ6tdafmh+7GQnYHPqDTTV2bp8yw2tJl6XU5eu7hjLCGms8Id+h5LevqrL1KgG0kIEa7Zq52L9WHQ/uA8YenFoxWImEiUw1EaSenrWIVzLigEc7xN7kWaz3isZdCpVPBmwnEVDNHJDteMfJXNTULORGHqa+mBph/khcFxvvirjp+5+dn/Igxy6bgIGIaYMjvlJ7rNJ1+hxak96WyDVe5FcYFSyYn0vNy+In83LF8s0arXh3/gmH4HFMUiQUdoeD5fnvCfSFB2Oc7AFelJh0X9x3LlzOmcoBqRSiUa/tQpgBugSIVzTM2LAnMmpUX2cYs+Abv8wHU0tGodtyTpMS/ my.local
  EOF
  network {
    model = "virtio"
    bridge = "vmbr0"
    tag = 3
  }
  disk {
    type = "scsi"
    storage = "zfsimage"
    size = "32G"
  }
}