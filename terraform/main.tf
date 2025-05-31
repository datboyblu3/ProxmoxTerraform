locals {
    network              = "vmbr0"
    image                = "ubuntu-temp" 
    ssh_user             = "worldboss"
    private_key_path     = ""

    target_servers = {
      target-1 = {
        machine_type = "ubuntu-server"
        name         = "nginx"
    }
      target-2 = {
        machine_type = "ubuntu-server"
        name         = "wordpress"
    }

      target-3 = {
        machine_type = "ubuntu-server"
        name         = "smb"
    }
}


resource "proxmox_vm_qemu" "vm-instance" {

  for each = local.target_servers
    name                = "vm-instance"
    target_node         = "pve"
    clone               = "your-template-name"
    full_clone          = true
    cores               = 2
    memory              = 2048

    disk {
        size            = "32G"
        type            = "scsi"
        storage         = "your-storage-volume"
        discard         = "on"
    }

    network {
        model     = "virtio"
        bridge    = "vmbr0"
        firewall  = false
        link_down = false
    }

    provisioner "local-exec" {
       command     = "ansible-playbook -i '${self.public_ip},'  -u opc --private-key '~/.ssh/oci_key' -e '~/.ssh/oci_key.pub' get_stager.yml -vvv --ask-become-pass"
      }

}
