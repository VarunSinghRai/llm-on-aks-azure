output "workspace_id" {
  description = "Resource ID of the Log Analytics workspace."
  value       = azurerm_log_analytics_workspace.name.id
}

output "workspace_key" {
  description = "Primary shared key for the Log Analytics workspace."
  value       = azurerm_log_analytics_workspace.name.primary_shared_key
  sensitive   = true
}
