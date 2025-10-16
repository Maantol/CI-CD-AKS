data "tfe_workspace" "tfe-workspace" {
  name         = "CI-CD-AKS"
  organization = "maantol"
}

resource "azurecaf_name" "resource_group" {
  name          = var.base_name
  resource_type = "azurerm_resource_group"
  suffixes      = ["dev"]
}

resource "azurerm_resource_group" "webapp" {
  name       = azurecaf_name.resource_group.result
  location   = var.azure_location
  depends_on = [azurecaf_name.resource_group]
}

resource "tfe_variable_set" "TLS" {
  name = "TLS"
}

resource "tfe_workspace_variable_set" "TLS" {
  variable_set_id = tfe_variable_set.TLS.id
  workspace_id    = data.tfe_workspace.tfe-workspace.id
}

resource "tfe_variable" "aks_public_key" {
  key             = "SSH_PUBLIC_KEY"
  value           = tls_private_key.ssh-key.public_key_openssh
  category        = "terraform"
  workspace_id    = data.tfe_workspace.tfe-workspace.id
  sensitive       = false
  variable_set_id = tfe_variable_set.TLS.id
  depends_on      = [azurerm_ssh_public_key.ssh]
}