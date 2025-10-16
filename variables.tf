variable "azure_location" {
  type        = string
  default     = "westeurope"
  description = "Azure location for all resources"
}

variable "base_name" {
  type        = string
  default     = "webapp"
  description = "Base name for all resources"
}

variable "network_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "hcp_terraform_organization" {
  type        = string
  description = "HCP Terraform organization name"
  default = "maantol"
}

variable "hcp_terraform_project" {
  type        = string
  description = "HCP Terraform project name"
  default = "matti-CI-CD-AKS"
}

variable "hcp_terraform_workspace" {
  type        = string
  description = "HCP Terraform workspace name"
  default     = "CI-CD-AKS"
}