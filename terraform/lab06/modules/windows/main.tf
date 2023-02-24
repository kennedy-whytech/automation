resource "azurerm_network_interface" "wvm_nic1" {
  for_each            = var.wvm_name
  name                = "${each.key}-nic1"
  location            = var.wvm_location
  resource_group_name = var.wvm_resource_group_name
  tags                = local.common_tags

  ip_configuration {
    name                          = "${each.key}-ipconfig1"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.subnet2_id
    public_ip_address_id          = azurerm_public_ip.wvm_pip[each.key].id
  }
}

resource "azurerm_public_ip" "wvm_pip" {
  for_each            = var.wvm_name
  name                = "${each.key}-pip"
  location            = var.wvm_location
  resource_group_name = var.wvm_resource_group_name
  allocation_method   = "Dynamic"
  domain_name_label   = each.key
  tags                = local.common_tags

}

resource "azurerm_windows_virtual_machine" "wvm" {
  for_each            = var.wvm_name
  name                = each.key
  location            = var.wvm_location
  resource_group_name = var.wvm_resource_group_name
  size                = each.value
  admin_username      = var.wvm_os_profile.admin_username
  admin_password      = var.wvm_os_profile.admin_password
  computer_name       = each.key

  tags                  = local.common_tags
  availability_set_id   = azurerm_availability_set.wvm_as1.id
  network_interface_ids = [azurerm_network_interface.wvm_nic1[each.key].id]

  os_disk {
    name                 = "${each.key}-os-disk"
    storage_account_type = var.wvm_os_disk_attributes.storage_account_type
    disk_size_gb         = var.wvm_os_disk_attributes.disk_size
    caching              = var.wvm_os_disk_attributes.caching
  }

  source_image_reference {
    publisher = var.wvm_os_info.publisher
    offer     = var.wvm_os_info.offer
    sku       = var.wvm_os_info.sku
    version   = var.wvm_os_info.version
  }
  winrm_listener {
    protocol = "Http"
  }
}
resource "azurerm_availability_set" "wvm_as1" {
  name                         = var.wvm_as1.name
  location                     = var.wvm_location
  resource_group_name          = var.wvm_resource_group_name
  platform_fault_domain_count  = var.wvm_as1.platform_fault_domain_count
  platform_update_domain_count = var.wvm_as1.platform_update_domain_count
  tags                         = local.common_tags
}