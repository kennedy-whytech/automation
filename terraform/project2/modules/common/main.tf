resource "azurerm_log_analytics_workspace" "lg_workspace" {
  name                = var.lg_workspace_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  sku                 = "PerGB2018"
  retention_in_days   = var.lg_workspace_retention_in_days
}

resource "azurerm_recovery_services_vault" "rs_vault" {
  name                = var.rs_vault_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  sku                 = "Standard"
  soft_delete_enabled = true
}

resource "azurerm_storage_account" "sa1" {
  name                     = var.sa1_name
  resource_group_name      = var.rg_name
  location                 = var.rg_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
