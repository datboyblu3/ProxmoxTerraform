resource "proxmox_vm_qemu" "vm-instance" {
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
        bridge    = "vmbr1"
        firewall  = false
        link_down = false
    }

}
