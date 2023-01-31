resource "azurerm_network_interface" "nic1" {
  name                = "${var.linux_name}-nic1"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  tags                = local.common_tags

  ip_configuration {
    name                          = "${var.linux_name}-ipconfig1"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.network-subnet1.id
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

resource "azurerm_public_ip" "pip" {
  name                = "${var.linux_name}-pip"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.linux_name}"
  tags                = local.common_tags

}

resource "azurerm_linux_virtual_machine" "lvm" {
  name                         = "${var.linux_name}"
  location                     = azurerm_resource_group.network-rg.location
  resource_group_name          = azurerm_resource_group.network-rg.name
  size                         = var.size
  admin_username               = var.admin_username
  tags                         = local.common_tags
  admin_ssh_key {
    username = var.admin_username
    public_key = file(var.public_key)
  }
  network_interface_ids = [azurerm_network_interface.nic1.id]#, azurerm_network_interface.nic2.id]

  os_disk {
    name                 = "${var.linux_name}-os-disk"
    storage_account_type = var.os_disk_attributes.storage_account_type
    disk_size_gb         = var.os_disk_attributes.disk_size
    caching              = var.os_disk_attributes.caching
  }

    computer_name                   = "${var.linux_name}"
    disable_password_authentication = true

  source_image_reference {
    publisher = var.ubuntu_linux_os_info.publisher
    offer     = var.ubuntu_linux_os_info.offer
    sku       = var.ubuntu_linux_os_info.sku
    version   = var.ubuntu_linux_os_info.version
  }
}
