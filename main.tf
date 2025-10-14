resource "azurecaf_name" "resource_group" {
  name          = "demogroup"
  resource_type = "azurerm_resource_group"
  prefixes      = ["a", "b"]
  suffixes      = ["y", "z"]
  random_length = 5
  clean_input   = true
}

resource "azurerm_resource_group" "example" {
  name     = azurecaf_name.resource_group.result
  location = var.azure_location
}