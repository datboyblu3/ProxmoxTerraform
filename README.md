# Proxmox Terraform
This repository automates the provisioning of virtual machines and other infrastructure components on a Proxmox Virtual Environment (PVE) cluster using Terraform.

 ## 🔧 Overview

Terraform enables Infrastructure as Code (IaC) for Proxmox, allowing you to define, version, and deploy VMs in a consistent and repeatable manner. This setup is ideal for homelabs, development environments, or production workloads managed through Proxmox.

 ## 🚀 Features

Declarative VM provisioning on Proxmox VE

Cloud-init support for Linux VMs

Template-based VM creation

Customizable CPU, memory, disk, and network configurations

SSH key injection for secure access

Scalable and reusable infrastructure definitions

 ## 📦 Requirements
Terraform >= 1.0

Proxmox VE >= 6.x

Terraform Proxmox Provider: danitso/terraform-provider-proxmox or community fork

API access to Proxmox with a user/token

Pre-created Proxmox VM template (cloud-init compatible)

## 🛠 Setup

**1) Clone Repo**

```go
git clone https://github.com/your-org/proxmox-terraform-infra.git
cd proxmox-terraform-infra
```

**2) Configure your Terraform variables**

Edit the terraform.tfvars or provide input variables for:
- Proxmox endpoint
- API credentials
- Template name
- VM specs (name, CPU, memory, etc.)

**3) Initialize Terraform**

```go
terraform init
```

**4) Plan and Apply **
```go
terraform plan
terraform apply
```

## Example

```go
resource "proxmox_vm_qemu" "ubuntu_vm" {
  name   = "ubuntu01"
  target_node = "pve-node1"
  clone  = "ubuntu-cloudinit-template"
  
  cores  = 2
  memory = 2048
  disk {
    size = "10G"
    type = "scsi"
  }

  network {
    model = "virtio"
    bridge = "vmbr0"
  }

  sshkeys = file("~/.ssh/id_rsa.pub")
}
```
