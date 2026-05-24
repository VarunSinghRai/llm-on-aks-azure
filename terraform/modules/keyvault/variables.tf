variable "name" {
  type        = string
  description = "Globally unique name for the Key Vault (3-24 chars)."
}

variable "location" {
  type        = string
  description = "Azure region."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group to deploy into."
}

variable "tenant_id" {
  type        = string
  description = "Azure AD tenant ID."
}

variable "sku_name" {
  type        = string
  description = "Key Vault SKU. One of: standard, premium."
  default     = "standard"
}

variable "soft_delete_enabled" {
  type        = bool
  description = "Enable soft delete."
  default     = true
}

variable "purge_protection_enabled" {
  type        = bool
  description = "Enable purge protection."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Resource tags."
  default     = {}
}
