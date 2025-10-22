data "azurerm_kubernetes_cluster" "k8s" {
  name                = azurecaf_name.AKS
  resource_group_name = azurerm_kubernetes_cluster.k8s
  depends_on          = [azurerm_kubernetes_cluster.k8s]
}


resource "azurecaf_name" "AKS" {
  name          = var.base_name
  resource_type = "azurerm_kubernetes_cluster"
  suffixes      = ["dev", "${var.azure_location}"]
  clean_input   = true
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                      = azurecaf_name.AKS.result
  location                  = var.azure_location
  resource_group_name       = azurecaf_name.resource_group.result
  dns_prefix                = "${azurecaf_name.AKS.result}-dns"
  kubernetes_version        = "1.32"
  automatic_upgrade_channel = "stable"
  node_resource_group       = "${azurecaf_name.resource_group.result}-nodepool"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2s_v6"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
  depends_on = [azurerm_resource_group.webapp]
}