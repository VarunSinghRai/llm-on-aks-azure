variable "cluster_name" {
  type        = string
  description = "Name of the AKS cluster."
}

variable "location" {
  type        = string
  description = "Azure region."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group to deploy into."
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix for the AKS API server."
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

variable "tags" {
  type        = map(string)
  description = "Resource tags."
  default     = {}
}
