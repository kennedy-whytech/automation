resource "azurerm_virtual_network" "network-vnet" {
  name                = var.virtual_network_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  address_space       = var.virtual_network_address_space
}

resource "azurerm_subnet" "network-subnet1" {
  name                 = var.subnet1_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.network-vnet.name
  address_prefixes     = var.subnet1_address_space
}

resource "azurerm_network_security_group" "network-nsg1" {
  name                = var.network_security_group1_name
  location            = var.rg_location
  resource_group_name = var.rg_name

  # Not required, but it's safer to add them
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
  security_rule {
    name                       = "rule2"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "rule3"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5985"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "rule4"
    priority                   = 400
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "network-subnet1-nsg1" {
  subnet_id                 = azurerm_subnet.network-subnet1.id
  network_security_group_id = azurerm_network_security_group.network-nsg1.id
}