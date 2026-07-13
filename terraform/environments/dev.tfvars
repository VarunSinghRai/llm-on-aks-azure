# =============================================================================
# Global
# =============================================================================
location = "eastus"

tags = {
  environment = "dev"
  project     = "llm-on-aks"
  owner       = "platform-team"
  managed_by  = "terraform"
}

# =============================================================================
# Resource Group
# =============================================================================
resource_group_name = "rg-llm-aks-dev"

# =============================================================================
# Networking
# =============================================================================
vnet_name     = "vnet-llm-aks-dev"
address_space = ["10.0.0.0/16"]

subnets = {
  aks-system = {
    address_prefixes = ["10.0.1.0/24"]
  }
  aks-user = {
    address_prefixes = ["10.0.2.0/24"]
  }
  private-endpoints = {
    address_prefixes = ["10.0.3.0/24"]
  }
}

# =============================================================================
# Azure Container Registry
# =============================================================================
acr_name = "acrllmaksdev" # must be globally unique, alphanumeric only
acr_sku  = "Basic"

# =============================================================================
# AKS Cluster
# =============================================================================
cluster_name = "aks-llm-dev"
dns_prefix   = "llm-dev"
node_count   = 2
vm_size      = "Standard_D4s_v3" # swap for Standard_NC6s_v3 in prod (GPU)

# =============================================================================
# Key Vault
# =============================================================================
keyvault_name            = "kv-llm-aks-dev" # 3-24 chars, globally unique
tenant_id                = "66f1ce9d-63de-48db-9e03-5cb14865d24f"
keyvault_sku             = "standard"
soft_delete_enabled      = true
purge_protection_enabled = false # false in dev so the vault can be destroyed cleanly

# =============================================================================
# Monitoring (Log Analytics Workspace)
# =============================================================================
workspace_name = "law-llm-aks-dev"
workspace_sku  = "PerGB2018"
