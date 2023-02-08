output "VM_hostname" {
  value = [azurerm_linux_virtual_machine.lvm[*].computer_name]
}

output "VM_DNS_label" {
  value = [azurerm_public_ip.pip[*].domain_name_label]
}

output "VM_FQDN" {
  value = [azurerm_public_ip.pip[*].fqdn]
}

output "Private_IP_address" {
  value = [azurerm_network_interface.nic1[*].private_ip_address]
}

# Dynamic Public IP Addresses aren't allocated until they're attached to a device (e.g. a Virtual Machine/Load Balancer).
# output "Public_IP_address" {
#   value = azurerm_public_ip.pip.ip_address
# }
# data "azurerm_public_ip" "pip_data" {
#   name                = azurerm_public_ip.pip[*].name
#   resource_group_name = azurerm_linux_virtual_machine.lvm[*].resource_group_name
# }

output "public_ip_address" {
  value = [azurerm_linux_virtual_machine.lvm[*].public_ip_address]
}

output "Virtual_network_name" {
  value = azurerm_virtual_network.network-vnet.name
}

output "Virtual_network_address_space" {
  value = azurerm_virtual_network.network-vnet.address_space
}

output "Subnet_1_name" {
  value = azurerm_subnet.network-subnet1.name
}

output "Subnet_1_address_space" {
  value = azurerm_subnet.network-subnet1.address_prefixes
}

output "Subnet_2_name" {
  value = azurerm_subnet.network-subnet2.name
}

output "Subnet_2_address_space" {
  value = azurerm_subnet.network-subnet2.address_prefixes
}

output "Linux_availability_set_name"{
  value = azurerm_availability_set.as1.name
}