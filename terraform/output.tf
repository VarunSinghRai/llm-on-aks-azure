output "resource_group_name" {
  description = "Name of the deployed resource group."
  value       = module.resource_group.resource_group_name
}

output "vnet_id" {
  description = "Resource ID of the virtual network."
  value       = module.networking.vnet_id
}

output "acr_login_server" {
  description = "Login server URL for the container registry."
  value       = module.acr.login_server
}

output "aks_cluster_name" {
  description = "Name of the AKS cluster."
  value       = module.aks.cluster_name
}

output "aks_kube_config" {
  description = "Raw kubeconfig for the AKS cluster."
  value       = module.aks.kube_config_raw
  sensitive   = true
}

output "keyvault_uri" {
  description = "URI of the Key Vault."
  value       = module.keyvault.vault_uri
}

output "log_analytics_workspace_id" {
  description = "Resource ID of the Log Analytics workspace."
  value       = module.monitoring.workspace_id
}
