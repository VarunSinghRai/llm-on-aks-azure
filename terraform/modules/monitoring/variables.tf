variable "name" {
  type        = string
  description = "Name of the Log Analytics workspace."
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
  description = "Log Analytics workspace SKU."
  default     = "PerGB2018"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags."
  default     = {}
}
