# Resource group for networking
resource "azurerm_resource_group" "rg1" {
  name     = var.rg1_name
  location = var.rg1_location
  tags     = local.common_tags
}