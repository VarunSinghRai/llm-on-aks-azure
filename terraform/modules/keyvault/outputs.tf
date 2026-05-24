output "vault_uri" {
  description = "URI of the Key Vault."
  value       = azurerm_key_vault.aks_kv.vault_uri
}

output "keyvault_id" {
  description = "Resource ID of the Key Vault."
  value       = azurerm_key_vault.aks_kv.id
}
