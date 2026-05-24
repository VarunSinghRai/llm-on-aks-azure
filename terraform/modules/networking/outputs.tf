output "vnet_id" {
  description = "Resource ID of the virtual network."
  value       = azurerm_virtual_network.aksvnet.id
}

output "vnet_name" {
  description = "Name of the virtual network."
  value       = azurerm_virtual_network.aksvnet.name
}

output "subnet_ids" {
  description = "Map of subnet name to resource ID."
  value       = { for k, v in azurerm_subnet.aksubnet : k => v.id }
}
