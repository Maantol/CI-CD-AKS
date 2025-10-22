provider "helm" {
  kubernetes = {
    host                   = data.azurerm_kubernetes_cluster.k8s.kube_config[0].host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.k8s.kube_config[0].client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.k8s.kube_config[0].client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.k8s.kube_config[0].cluster_ca_certificate)
  }
}

data "azurerm_kubernetes_cluster" "k8s" {
  name                = azurecaf_name.AKS.result
  resource_group_name = azurecaf_name.resource_group.result
  depends_on          = [azurerm_kubernetes_cluster.k8s]
}

resource "helm_release" "azure-vote" {
  name       = "azure-vote"
  repository = "https://azure-samples.github.io/helm-charts/"
  chart      = "azure-vote"

  values = [
    file("${path.module}/values/values.yaml")
  ]

  depends_on = [azurerm_kubernetes_cluster.k8s]


}