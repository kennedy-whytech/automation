output "lg_workspace_id" {
  value = azurerm_log_analytics_workspace.lg_workspace.id
}

output "rs_vault_id" {
  value = azurerm_recovery_services_vault.rs_vault.id
}

output "sa1_id" {
  value = azurerm_storage_account.sa1.id
}

output "lg_workspace_name" {
  value = azurerm_log_analytics_workspace.lg_workspace.name
}

output "rs_vault_name" {
  value = azurerm_recovery_services_vault.rs_vault.name
}

output "sa1_name" {
  value = azurerm_storage_account.sa1.name
}

output "sa1_primary_blob_endpoint" {
  value = azurerm_storage_account.sa1.primary_blob_endpoint
}

output "sa1_obj" {
  value = azurerm_storage_account.sa1
}
