terraform {
  backend "azurerm" {
    resource_group_name  = "tfstaten01538887RG"
    storage_account_name = "tfstaten015388887sa"
    container_name       = "tfstatefiles"
    key                  = "tfstate"
  }
}
