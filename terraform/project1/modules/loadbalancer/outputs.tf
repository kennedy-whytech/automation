output "lb_name" {
  value = azurerm_lb.lb.name
}
output "lb_pip" {
  value = azurerm_public_ip.lb_pip.ip_address
}