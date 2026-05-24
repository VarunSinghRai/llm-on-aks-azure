# =============================================================================
# Global
# =============================================================================
variable "location" {
  type        = string
  description = "Azure region for all resources."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to every resource."
  default     = {}
}

# =============================================================================
# Resource Group
# =============================================================================
variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

# =============================================================================
# Networking
# =============================================================================
variable "vnet_name" {
  type        = string
  description = "Name of the virtual network."
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

# =============================================================================
# Azure Container Registry
# =============================================================================
variable "acr_name" {
  type        = string
  description = "Globally unique name for the container registry (alphanumeric only)."
}

variable "acr_sku" {
  type        = string
  description = "ACR SKU. One of: Basic, Standard, Premium."
  default     = "Basic"
}

# =============================================================================
# AKS Cluster
# =============================================================================
variable "cluster_name" {
  type        = string
  description = "Name of the AKS cluster."
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix for the AKS cluster."
}

variable "node_count" {
  type        = number
  description = "Number of nodes in the default node pool."
  default     = 2
}

variable "vm_size" {
  type        = string
  description = "VM size for the default node pool."
  default     = "Standard_D4s_v3"
}

# =============================================================================
# Key Vault
# =============================================================================
variable "keyvault_name" {
  type        = string
  description = "Globally unique name for the Key Vault (3-24 chars)."
}

variable "tenant_id" {
  type        = string
  description = "Azure AD tenant ID."
}

variable "keyvault_sku" {
  type        = string
  description = "Key Vault SKU. One of: standard, premium."
  default     = "standard"
}

variable "soft_delete_enabled" {
  type        = bool
  description = "Enable soft delete on the Key Vault."
  default     = true
}

variable "purge_protection_enabled" {
  type        = bool
  description = "Enable purge protection on the Key Vault."
  default     = false
}

# =============================================================================
# Monitoring
# =============================================================================
variable "workspace_name" {
  type        = string
  description = "Name of the Log Analytics workspace."
}

variable "workspace_sku" {
  type        = string
  description = "Log Analytics workspace SKU."
  default     = "PerGB2018"
}
