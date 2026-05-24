# =============================================================================
# Global
# =============================================================================
location = "eastus"

tags = {
  environment = "prod"
  project     = "llm-on-aks"
  owner       = "platform-team"
  managed_by  = "terraform"
}

# =============================================================================
# Resource Group
# =============================================================================
resource_group_name = "rg-llm-aks-prod"

# =============================================================================
# Networking
# =============================================================================
vnet_name     = "vnet-llm-aks-prod"
address_space = ["10.1.0.0/16"]

subnets = {
  aks-system = {
    address_prefixes = ["10.1.1.0/24"]
  }
  aks-user = {
    address_prefixes = ["10.1.2.0/24"]
  }
  private-endpoints = {
    address_prefixes = ["10.1.3.0/24"]
  }
}

# =============================================================================
# Azure Container Registry
# =============================================================================
acr_name = "acrllmaksprod"   # must be globally unique, alphanumeric only
acr_sku  = "Premium"          # enables geo-replication and private link

# =============================================================================
# AKS Cluster
# =============================================================================
cluster_name = "aks-llm-prod"
dns_prefix   = "llm-prod"
node_count   = 3
vm_size      = "Standard_NC6s_v3"   # GPU nodes for LLM inference workloads

# =============================================================================
# Key Vault
# =============================================================================
keyvault_name            = "kv-llm-aks-prod"   # 3-24 chars, globally unique
tenant_id                = "00000000-0000-0000-0000-000000000000"   # replace with: az account show --query tenantId -o tsv
keyvault_sku             = "premium"
soft_delete_enabled      = true
purge_protection_enabled = true   # prevents accidental permanent deletion in prod

# =============================================================================
# Monitoring (Log Analytics Workspace)
# =============================================================================
workspace_name = "law-llm-aks-prod"
workspace_sku  = "PerGB2018"
