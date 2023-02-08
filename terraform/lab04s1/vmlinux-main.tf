resource "azurerm_network_interface" "nic1" {
  count               = var.nb_count 
  name                = "${var.linux_name}-${format("%1d", count.index+1)}-nic1"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  tags                = local.common_tags

  ip_configuration {
    name                          = "${var.linux_name}-${format("%1d", count.index+1)}-ipconfig1"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.network-subnet1.id
    public_ip_address_id          = azurerm_public_ip.pip[count.index].id
  }
}

resource "azurerm_public_ip" "pip" {
  count               = var.nb_count 
  name                = "${var.linux_name}-${format("%1d", count.index+1)}-pip"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.linux_name}-${format("%1d", count.index+1)}"
  tags                = local.common_tags

}

resource "azurerm_linux_virtual_machine" "lvm" {
  count                        = var.nb_count 
  name                         = "${var.linux_name}-${format("%1d", count.index+1)}" #"${var.linux_name}-${format("%1d", count.index+1)}"
  location                     = azurerm_resource_group.network-rg.location
  resource_group_name          = azurerm_resource_group.network-rg.name
  size                         = var.size
  admin_username               = var.admin_username
  tags                         = local.common_tags
  availability_set_id          = azurerm_availability_set.as1.id
  admin_ssh_key {
    username = var.admin_username
    public_key = file(var.public_key)
  }
  #network_interface_ids = [element(azurerm_network_interface.nic1[*].id, count.index+1)]
  network_interface_ids = [azurerm_network_interface.nic1[count.index].id]

  os_disk {
    name                 = "${var.linux_name}-${format("%1d", count.index+1)}-os-disk"
    storage_account_type = var.os_disk_attributes.storage_account_type
    disk_size_gb         = var.os_disk_attributes.disk_size
    caching              = var.os_disk_attributes.caching
  }

    computer_name                   = "${var.linux_name}-${format("%1d", count.index+1)}"
    disable_password_authentication = true

  source_image_reference {
    publisher = var.ubuntu_linux_os_info.publisher
    offer     = var.ubuntu_linux_os_info.offer
    sku       = var.ubuntu_linux_os_info.sku
    version   = var.ubuntu_linux_os_info.version
  }
}
resource "azurerm_availability_set" "as1" {
  name                          = var.linux_avs.name
  location                      = azurerm_resource_group.network-rg.location
  resource_group_name           = azurerm_resource_group.network-rg.name
  platform_fault_domain_count   = var.linux_avs.platform_fault_domain_count
  platform_update_domain_count  = var.linux_avs.platform_update_domain_count
  tags                          = local.common_tags
}