output "login_server" {
  description = "Login server URL for the container registry."
  value       = azurerm_container_registry.acr.login_server
}

output "acr_id" {
  description = "Resource ID of the container registry."
  value       = azurerm_container_registry.acr.id
}
