variable "azure_location" {
  type        = string
  default     = "eastus"
  description = "Azure location for all resources"
}

variable "network_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}
