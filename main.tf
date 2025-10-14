resource "azurecaf_name" "resource_group" {
  name          = "webapp"
  resource_type = "azurerm_resource_group"
  suffixes = ["dev"]
}

resource "azurerm_resource_group" "example" {
  name     = azurecaf_name.resource_group.result
  location = var.azure_location
}