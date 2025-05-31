locals {
    network              = "vmbr0"
    image                = "ubuntu-temp" 
    ssh_user             = "worldboss"
    storage              = "local-lvm"
    target_node          = "pve"
    private_key_path     = ""

    target_servers = {
      target-1 = {
        machine_type        = "ubuntu-server"
        target_name         = "nginx"
    }
      target-2 = {
        machine_type        = "ubuntu-server"
        target_name         = "wordpress"
    }

      target-3 = {
        machine_type        = "ubuntu-server"
        target_name         = "smb"
    }
  }
}


resource "proxmox_vm_qemu" "vm-instance" {

  for_each = local.target_servers
    target_server_id    = each.key
    name                = each.value.target_name
    machine_type        = each.value.machine_type

    node                = local.target_node
    clone               = local.image
    full_clone          = true
    cores               = 2
    memory              = 4000

    disk {
        size            = "32G"
        type            = "scsi"
        storage         = local.storage
        discard         = "on"
    }

    network {
        model     = "virtio"
        bridge    = local.network
        firewall  = false
        link_down = false
    }

    provisioner "local-exec" {
       command     = "ansible-playbook -i '${self.public_ip},'"
      }

}

output "target_server_ips" {
  value = {
    for k, v in proxmox_vm_qemu : k => "http://${}" # Still working
  }
}
