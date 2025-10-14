resource "azurecaf_name" "resource_group" {
  name          = var.base_name
  resource_type = "azurerm_resource_group"
  suffixes      = ["dev"]
}

resource "azurerm_resource_group" "webapp" {
  name     = azurecaf_name.resource_group.result
  location = var.azure_location
}