resource "azurecaf_name" "AKS" {
  name          = var.base_name
  resource_type = "azurerm_kubernetes_cluster"
  suffixes      = ["dev", "${var.azure_location}"]
  clean_input   = true
}

resource "tls_private_key" "ssh-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_ssh_public_key" "ssh" {
  name                = "azure-ssh"
  resource_group_name = azurecaf_name.resource_group.result
  location            = var.azure_location
  public_key          = tls_private_key.ssh-key.public_key_openssh
  depends_on          = [azurerm_resource_group.webapp]
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
  linux_profile {
    admin_username = "testuser"
    ssh_key {
      key_data = tls_private_key.ssh-key.public_key_openssh
    }
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