resource "azurerm_network_interface" "nic1_w" {
  for_each            = var.windows_name
  name                = "${each.key}-nic1"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  tags                = local.common_tags

  ip_configuration {
    name                          = "${each.key}-ipconfig1"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.network-subnet2.id
    public_ip_address_id          = azurerm_public_ip.pip_w[each.key].id
  }
}

resource "azurerm_public_ip" "pip_w" {
  for_each            = var.windows_name
  name                = "${each.key}-pip"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  allocation_method   = "Dynamic"
  domain_name_label   = "${each.key}"
  tags                = local.common_tags

}

resource "azurerm_windows_virtual_machine" "wvm" {
  for_each                     = var.windows_name
  name                         = each.key
  location                     = azurerm_resource_group.network-rg.location
  resource_group_name          = azurerm_resource_group.network-rg.name
  size                         = "${each.value}"
  admin_username               = var.windows_os_profile.admin_username
  admin_password               = var.windows_os_profile.admin_password
  computer_name                = "${each.key}"

  tags                         = local.common_tags
  availability_set_id          = azurerm_availability_set.as1_windows.id
  network_interface_ids = [azurerm_network_interface.nic1_w[each.key].id]

  os_disk {
    name                 = "${each.key}-os-disk"
    storage_account_type = var.windows_os_disk_attributes.storage_account_type
    disk_size_gb         = var.windows_os_disk_attributes.disk_size
    caching              = var.windows_os_disk_attributes.caching
  }

  source_image_reference {
    publisher = var.windows_os_info.publisher
    offer     = var.windows_os_info.offer
    sku       = var.windows_os_info.sku
    version   = var.windows_os_info.version
  }
  winrm_listener {
    protocol = "Http"
  }
}
resource "azurerm_availability_set" "as1_windows" {
  name                          = var.windows_avs.name
  location                      = azurerm_resource_group.network-rg.location
  resource_group_name           = azurerm_resource_group.network-rg.name
  platform_fault_domain_count   = var.windows_avs.platform_fault_domain_count
  platform_update_domain_count  = var.windows_avs.platform_update_domain_count
  tags                          = local.common_tags
}
# resource "azurerm_availability_set" "as1" {
#   name                          = var.linux_avs.name
#   location                      = azurerm_resource_group.network-rg.location
#   resource_group_name           = azurerm_resource_group.network-rg.name
#   platform_fault_domain_count   = var.linux_avs.platform_fault_domain_count
#   platform_update_domain_count  = var.linux_avs.platform_update_domain_count
#   tags                          = local.common_tags
# }