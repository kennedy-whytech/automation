resource "azurerm_public_ip" "lb_pip" {
  name                = format("%s-pip", var.lb_name)
  location            = var.rg_location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = var.lb_sku # it has to be the same as the lb sku type
  domain_name_label   = format("%s", var.lb_name)

}

resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  sku                 = var.lb_sku

  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.lb_pip.id
    # private_ip_address_allocation = "Dynamic"
    # subnet_id                     = var.subnet1_id
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  name            = var.backend_pool_name
  loadbalancer_id = azurerm_lb.lb.id
}

resource "azurerm_lb_backend_address_pool_address" "lb_paddress_lvm" {
  count                   = length(var.lvm_private_ips)
  name                    = format("lb-paddress-lvm-%s", count.index)
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id

  # private ip address from virtual machine network interface asssociated with virtual machine 
  ip_address         = var.lvm_private_ips[count.index]
  virtual_network_id = var.network_vnet_id
}

# resource "azurerm_lb_backend_address_pool_address" "lb_paddress_wvm" {
#   count                   = length(var.wvm_private_ips)
#   name                    = format("lb-paddress-wvm-%s",count.index)
#   backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id

#   # private ip address from virtual machine network interface asssociated with virtual machine 
#   ip_address         = var.wvm_private_ips[count.index]
#   virtual_network_id = var.network_vnet_id
# }


# for health check
resource "azurerm_lb_probe" "lb_probe" {
  name             = "TcpProbe"
  protocol         = "Tcp"
  number_of_probes = 2
  port             = 80
  loadbalancer_id  = azurerm_lb.lb.id
}

resource "azurerm_lb_rule" "lb_rule" {
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  idle_timeout_in_minutes        = 4
  loadbalancer_id                = azurerm_lb.lb.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool.id]
  frontend_ip_configuration_name = var.frontend_ip_configuration_name
  probe_id                       = azurerm_lb_probe.lb_probe.id
  depends_on = [
    azurerm_lb.lb,
  ]
}