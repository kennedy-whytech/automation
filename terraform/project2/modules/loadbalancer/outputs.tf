output "lb_name" {
  value = azurerm_lb.lb.name
}
output "lb_pip" {
  value = azurerm_public_ip.lb_pip.ip_address
}
output "lb_fqdn" {
  value = azurerm_public_ip.lb_pip.fqdn
}