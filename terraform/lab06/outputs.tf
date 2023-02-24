# Resource Group
output "rg_network_name" {
  value = module.resource_group.rg_network_name
}

output "rg_linux_name" {
  value = module.resource_group.rg_linux_name
}

output "rg_windows_name" {
  value = module.resource_group.rg_windows_name
}

# Network
output "virtual_network_name" {
  value = module.network.virtual_network_name
}

output "virtual_network_address_space" {
  value = module.network.virtual_network_address_space
}

output "subnet1_name" {
  value = module.network.subnet1_name
}

output "subnet1_address_space" {
  value = module.network.subnet1_address_space
}

output "subnet2_name" {
  value = module.network.subnet2_name
}

output "subnet2_address_space" {
  value = module.network.subnet2_address_space
}

output "network_security_group1_name" {
  value = module.network.network_security_group1_name
}

output "network_security_group2_name" {
  value = module.network.network_security_group2_name
}

# Linux
output "lvm_hostnames" {
  value = module.linux.lvm_hostnames
}

output "lvm_private_ips" {
  value = module.linux.lvm_private_ips
}

output "lvm_public_ips" {
  value = module.linux.lvm_public_ips
}

output "lvm_availability_set" {
  value = module.linux.lvm_availability_set
}

output "lvm_fqdns" {
  value = module.linux.lvm_fqdns
}

# Windows
output "wvm_hostnames" {
  value = module.windows.wvm_hostnames
}

output "wvm_private_ip_address" {
  value = module.windows.wvm_private_ip_address
}

output "wvm_public_ip_address" {
  value = module.windows.wvm_public_ip_address
}

output "wvm_availability_set_name"{
  value = module.windows.wvm_availability_set_name
}

output "wvm_dns_label" {
  value = module.windows.wvm_dns_label
}

output "wvm_fqdn" {
  value = module.windows.wvm_fqdn
}


