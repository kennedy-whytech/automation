resource "azurerm_network_interface" "lvm_nic1" {
  count               = var.nb_count
  name                = "${var.lvm_name}${format("%1d", count.index)}-nic1"
  location            = var.rg_location
  resource_group_name = var.rg_name
  tags                = local.common_tags

  ip_configuration {
    name                          = "${var.lvm_name}${format("%1d", count.index)}-ipconfig1"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.subnet1_id
    public_ip_address_id          = azurerm_public_ip.lvm_pip[count.index].id
  }
}

resource "azurerm_public_ip" "lvm_pip" {
  count               = var.nb_count
  name                = "${var.lvm_name}${format("%1d", count.index)}-pip"
  location            = var.rg_location
  resource_group_name = var.rg_name
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.lvm_name}${format("%1d", count.index)}"
  tags                = local.common_tags
}

resource "azurerm_linux_virtual_machine" "lvm" {
  count               = var.nb_count
  name                = "${var.lvm_name}${format("%1d", count.index)}"
  location            = var.rg_location
  resource_group_name = var.rg_name
  size                = var.size
  admin_username      = var.admin_username
  tags                = local.common_tags
  availability_set_id = azurerm_availability_set.lvm_as1.id
  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key)
  }
  network_interface_ids = [azurerm_network_interface.lvm_nic1[count.index].id]

  os_disk {
    name                 = "${var.lvm_name}${format("%1d", count.index)}-os-disk"
    storage_account_type = var.os_disk_attributes.storage_account_type
    disk_size_gb         = var.os_disk_attributes.disk_size
    caching              = var.os_disk_attributes.caching
  }

  computer_name                   = "${var.lvm_name}${format("%1d", count.index)}"
  disable_password_authentication = true

  source_image_reference {
    publisher = var.lvm_os_info.publisher
    offer     = var.lvm_os_info.offer
    sku       = var.lvm_os_info.sku
    version   = var.lvm_os_info.version
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }
}

resource "azurerm_availability_set" "lvm_as1" {
  name                         = var.lvm_as1.name
  location                     = var.rg_location
  resource_group_name          = var.rg_name
  platform_fault_domain_count  = var.lvm_as1.platform_fault_domain_count
  platform_update_domain_count = var.lvm_as1.platform_update_domain_count
  tags                         = local.common_tags
}

resource "azurerm_network_watcher" "lvm_nw" {
  name                = "${var.lvm_name}-nw"
  location            = var.rg_location
  resource_group_name = var.rg_name
}

resource "azurerm_virtual_machine_extension" "lvm_vme" {
  count                = var.nb_count
  name                 = "${var.lvm_name}${format("%1d", count.index)}-vme"
  virtual_machine_id   = azurerm_linux_virtual_machine.lvm[count.index].id
  publisher            = "Microsoft.Azure.NetworkWatcher"
  type                 = "NetworkWatcherAgentLinux"
  type_handler_version = "1.4"
}


resource "azurerm_network_packet_capture" "lvm_npc" {
  count                = var.nb_count
  name                 = "${var.lvm_name}${format("%1d", count.index)}-npc"
  network_watcher_name = azurerm_network_watcher.lvm_nw.name
  resource_group_name  = var.rg_name
  target_resource_id   = azurerm_linux_virtual_machine.lvm[count.index].id

  storage_location {
    storage_account_id = var.sa1_id
  }

  depends_on = [azurerm_virtual_machine_extension.lvm_vme, azurerm_network_watcher.lvm_nw]
}