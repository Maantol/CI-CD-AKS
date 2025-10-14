resource "azurecaf_name" "AKS" {
  name          = var.base_name
  resource_type = "azurerm_kubernetes_cluster"
  suffixes      = ["dev", "${var.azure_location}"]
  random_length = 3
  clean_input   = true
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = azurecaf_name.AKS.result
  location            = var.azure_location
  resource_group_name = azurecaf_name.resource_group.result
  dns_prefix          = "${azurecaf_name.AKS.result}-dns"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
  depends_on = [azurerm_resource_group.webapp]
}