terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.47.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "2.0.0-preview3"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.70.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.1.0"
    }
  }
  cloud {
    hostname     = "app.eu.terraform.io"
    organization = "maantol"
    workspaces {
      name = "CI-CD-AKS"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "azurecaf" {}

provider "random" {}

provider "tfe" {
  hostname     = "app.eu.terraform.io"
  organization = var.hcp_terraform_organization
}