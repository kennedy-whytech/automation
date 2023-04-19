output "network_vnet_id" {
  value = azurerm_virtual_network.network-vnet.id
}

output "virtual_network_name" {
  value = azurerm_virtual_network.network-vnet.name
}

output "virtual_network_address_space" {
  value = azurerm_virtual_network.network-vnet.address_space
}

output "subnet1_name" {
  value = azurerm_subnet.network-subnet1.name
}

output "subnet1_address_space" {
  value = azurerm_subnet.network-subnet1.address_prefixes
}

output "network_security_group1_name" {
  value = azurerm_network_security_group.network-nsg1.name
}

output "subnet1_id" {
  value = azurerm_subnet.network-subnet1.id
}