locals {
    network_bridge      = "vmbr0"
    image               = "ubuntu-temp" 
    ssh_user            = "shabba"
    storage             = "local-lvm"
    target_node         = "pve"

    target_servers = {
      target-1 = {
        machine_type    = "ubuntu-server"
        target_name     = "nginx"
    }
      target-2 = {
        machine_type    = "ubuntu-server"
        target_name     = "wordpress"
    }

      target-3 = {
        machine_type    = "ubuntu-server"
        target_name     = "smb"
    }
  }
}


resource "proxmox_vm_qemu" "vm-instance" {

  for_each = local.target_servers
    
    name                = each.value.target_name
    target_node         = local.target_node
    clone               = local.image
    full_clone          = true
    cores               = 2
    memory              = 2000
    sockets             = 1
    os_type             = "cloud-init"

    disk {
        size            = "32G"
        type            = "disk"
        storage         = local.storage
        slot            = "scsi0"
    }

    network {
        bridge          = local.network_bridge
        model           = "virtio"
        firewall        = false
        link_down       = false
        id              = 0
    }

    /*provisioner "local-exec" {
       command          = "ansible-playbook -i '${self.public_ip},'"
      }*/

}

output "target_server_ips" {
  value = {
    #for k, v in proxmox_vm_qemu : k => "http://${v.network.0.bridge.0.nat}"
    for k, v in proxmox_vm_qemu.web : k => v.network[0].ip
  }
}
