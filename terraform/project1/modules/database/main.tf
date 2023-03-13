resource "azurerm_postgresql_server" "pg_db" {
  name                = var.database_instance_name
  location            = var.rg_location
  resource_group_name = var.rg_name


  sku_name                     = var.sku_name
  storage_mb                   = var.storage_mb
  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  auto_grow_enabled            = var.auto_grow_enabled

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  version                      = var.db_version
  ssl_enforcement_enabled      = var.auto_grow_enabled



  tags = local.common_tags
}

