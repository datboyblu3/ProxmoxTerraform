# ProxmoxTerraform
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
