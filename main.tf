provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  use_cli  = false
  use_oidc = true
}

provider "random" {}

resource "random_pet" "rg_name" {
  length    = 2
  separator = "-"
}

resource "random_pet" "network_name" {
  length = 1
}

resource "random_pet" "subnet_name" {
  length = 1
}

resource "azurerm_resource_group" "example" {
  name     = "rg-${random_pet.rg_name.id}"
  location = var.azure_location
}

resource "azurerm_virtual_network" "example" {
  name                = "${random_pet.network_name.id}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "${random_pet.subnet_name.id}-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}