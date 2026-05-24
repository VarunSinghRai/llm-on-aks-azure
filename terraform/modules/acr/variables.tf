variable "name" {
  type        = string
  description = "Globally unique name for the container registry (alphanumeric only)."
}

variable "location" {
  type        = string
  description = "Azure region."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group to deploy into."
}

variable "sku" {
  type        = string
  description = "ACR SKU. One of: Basic, Standard, Premium."
  default     = "Basic"
}
