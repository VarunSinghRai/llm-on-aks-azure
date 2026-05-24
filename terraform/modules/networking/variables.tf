variable "name" {
  type        = string
  description = "Name of the virtual network."
}

variable "location" {
  type        = string
  description = "Azure region."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group to deploy into."
}

variable "address_space" {
  type        = list(string)
  description = "Address space for the virtual network."
}

variable "subnets" {
  type = map(object({
    address_prefixes = list(string)
  }))
  description = "Map of subnet name to address prefixes."
}

variable "tags" {
  type        = map(string)
  description = "Resource tags."
  default     = {}
}
