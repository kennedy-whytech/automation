output "lvm_ids" {
  value = azurerm_linux_virtual_machine.lvm[*].id
}

output "lvm_names" {
  value = azurerm_linux_virtual_machine.lvm[*].name
}

output "lvm_private_ips" {
  value = azurerm_linux_virtual_machine.lvm[*].private_ip_address
}

output "lvm_public_ips" {
  value = azurerm_linux_virtual_machine.lvm[*].public_ip_address
}

output "lvm_availability_set" {
  value = azurerm_availability_set.lvm_as1
}

output "lvm_hostnames" {
  value = azurerm_linux_virtual_machine.lvm[*].computer_name
}

output "lvm_fqdns" {
  value = azurerm_public_ip.lvm_pip[*].fqdn
}

output "lvm_obj" {
  value = azurerm_linux_virtual_machine.lvm[*]
}