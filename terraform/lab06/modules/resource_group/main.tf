# Resource group for networking
resource "azurerm_resource_group" "rg_network" {
  name     = var.rg_network_name
  location = var.rg_location
  tags     = local.common_tags
}

# Resource group for Linux
resource "azurerm_resource_group" "rg_linux" {
  name     = var.rg_linux_name
  location = var.rg_location
  tags     = local.common_tags
}

# Resource group for Windows
resource "azurerm_resource_group" "rg_windows" {
  name     = var.rg_windows_name
  location = var.rg_location
  tags     = local.common_tags
}
