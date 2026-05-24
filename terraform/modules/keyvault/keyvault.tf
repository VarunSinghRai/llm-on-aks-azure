resource "azurerm_key_vault" "aks_kv" {
    name                        = var.name
    location                    = var.location
    resource_group_name         = var.resource_group_name
    tenant_id                   = var.tenant_id
    sku_name                    = var.sku_name
    #soft_delete_enabled         = var.soft_delete_enabled
    purge_protection_enabled    = var.purge_protection_enabled
    
    tags = var.tags
}
