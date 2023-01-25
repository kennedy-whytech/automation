provider "azurerm" {
   features {}
}
resource "azurerm_resource_group" "network-rg" {
  name     = "lab02-network-rg"
  location = "canadaeast"
}
resource "azurerm_virtual_network" "network-vnet" {
  name                = "lab02-network-vnet"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  address_space       = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "network-subnet1" {
  name                 = "lab02-network-subnet1"
  resource_group_name  = azurerm_resource_group.network-rg.name
  virtual_network_name = azurerm_virtual_network.network-vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}
resource "azurerm_subnet" "network-subnet2" {
  name                 = "lab02-network-subnet2"
  resource_group_name  = azurerm_resource_group.network-rg.name
  virtual_network_name = azurerm_virtual_network.network-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_network_security_group" "network-nsg1" {
  name                = "lab02-network-nsg1"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name

  security_rule {
    name                       = "rule1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_network_security_group" "network-nsg2" {
  name                = "lab02-network-nsg2"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name

  security_rule {
    name                       = "rule1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
    security_rule {
    name                       = "rule2"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5985"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "network-subnet1-nsg1" {
  subnet_id                 = azurerm_subnet.network-subnet1.id
  network_security_group_id = azurerm_network_security_group.network-nsg1.id
}
resource "azurerm_subnet_network_security_group_association" "network-subnet2-nsg2" {
  subnet_id                 = azurerm_subnet.network-subnet2.id
  network_security_group_id = azurerm_network_security_group.network-nsg2.id
}