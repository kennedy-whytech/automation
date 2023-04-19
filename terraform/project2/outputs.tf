# Resource Group
output "rg_name" {
  value = module.rgroup.rg1_name
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

output "network_security_group1_name" {
  value = module.network.network_security_group1_name
}

# Linux
output "lvm_ids" {
  value = module.linux.lvm_ids
}

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
output "wvm_ids" {
  value = module.windows.wvm_ids
}

output "wvm_hostnames" {
  value = module.windows.wvm_hostnames
}

output "wvm_private_ips" {
  value = module.windows.wvm_private_ips
}

output "wvm_public_ips" {
  value = module.windows.wvm_public_ips
}

output "wvm_availability_set_name" {
  value = module.windows.wvm_availability_set_name
}

output "wvm_dns_label" {
  value = module.windows.wvm_dns_label
}

output "wvm_fqdn" {
  value = module.windows.wvm_fqdn
}

# Managed Data Disks
output "md_names" {
  value = module.datadisk.md_names
}

# Loadbalancers
output "lb_names" {
  value = module.loadbalancer.lb_name
}

output "lb_pip" {
  value = module.loadbalancer.lb_pip
}

output lb_fqdn {
  value = module.loadbalancer.lb_fqdn
}


# DB
output "pg_db_name" {
  value = module.database.pg_db_name
}