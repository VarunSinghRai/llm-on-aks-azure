terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# -----------------------------------------------------------------------------
# Resource Group
# -----------------------------------------------------------------------------
module "resource_group" {
  source = "./modules/resourcegroup"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

# -----------------------------------------------------------------------------
# Networking
# -----------------------------------------------------------------------------
module "networking" {
  source = "./modules/networking"

  name                = var.vnet_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  address_space       = var.address_space
  subnets             = var.subnets
  tags                = var.tags

  depends_on = [module.resource_group]
}

# -----------------------------------------------------------------------------
# Azure Container Registry
# -----------------------------------------------------------------------------
module "acr" {
  source = "./modules/acr"

  name                = var.acr_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  sku                 = var.acr_sku

  depends_on = [module.resource_group]
}

# -----------------------------------------------------------------------------
# AKS Cluster
# -----------------------------------------------------------------------------
module "aks" {
  source = "./modules/aks"

  cluster_name        = var.cluster_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  dns_prefix          = var.dns_prefix
  node_count          = var.node_count
  vm_size             = var.vm_size
  tags                = var.tags

  depends_on = [module.networking]
}

# -----------------------------------------------------------------------------
# Key Vault
# -----------------------------------------------------------------------------
module "keyvault" {
  source = "./modules/keyvault"

  name                     = var.keyvault_name
  location                 = var.location
  resource_group_name      = module.resource_group.resource_group_name
  tenant_id                = var.tenant_id
  sku_name                 = var.keyvault_sku
  soft_delete_enabled      = var.soft_delete_enabled
  purge_protection_enabled = var.purge_protection_enabled
  tags                     = var.tags

  depends_on = [module.resource_group]
}

# -----------------------------------------------------------------------------
# Monitoring
# -----------------------------------------------------------------------------
module "monitoring" {
  source = "./modules/monitoring"

  name                = var.workspace_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  sku                 = var.workspace_sku
  tags                = var.tags

  depends_on = [module.resource_group]
}
