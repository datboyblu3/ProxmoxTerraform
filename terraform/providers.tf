terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.2-rc01"
    }
  }
}

provider "proxmox" {
  # Configuration options

    pm_api_url          = var.api_url
    pm_api_token_id     = var.api_token_id
    pm_api_token_secret = var.api_token_secret
    pm_tls_insecure     = true
}
