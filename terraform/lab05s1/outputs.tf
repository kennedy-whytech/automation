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

## Lab04s2- windows
# output "Windows_availability_set_name"{
#   value = azurerm_availability_set.as1_windows.name
# }

# output "VM_hostname_w" {
#   value = values(azurerm_windows_virtual_machine.wvm)[*].computer_name
# }

# output "VM_DNS_label_w" {
#   value = values(azurerm_public_ip.pip_w)[*].domain_name_label
# }

# output "VM_FQDN_w" {
#   value = values(azurerm_public_ip.pip_w)[*].fqdn
# }

# output "Private_IP_address_w" {
#   value = values(azurerm_network_interface.nic1_w)[*].private_ip_address
# }

# output "public_ip_address_w" {
#   value = values(azurerm_windows_virtual_machine.wvm)[*].public_ip_address
# }