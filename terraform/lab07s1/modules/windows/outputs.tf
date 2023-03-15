output "wvm_hostnames" {
  value = values(azurerm_windows_virtual_machine.wvm)[*].computer_name
}

output "wvm_private_ip_address" {
  value = values(azurerm_network_interface.wvm_nic1)[*].private_ip_address
}

output "wvm_public_ip_address" {
  value = values(azurerm_windows_virtual_machine.wvm)[*].public_ip_address
}

output "wvm_availability_set_name" {
  value = azurerm_availability_set.wvm_as1.name
}

output "wvm_dns_label" {
  value = values(azurerm_public_ip.wvm_pip)[*].domain_name_label
}

output "wvm_fqdn" {
  value = values(azurerm_public_ip.wvm_pip)[*].fqdn
}

