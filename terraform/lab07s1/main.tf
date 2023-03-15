locals {
  common_tags = {
    Name         = "Terraform-Class"
    Project      = "Learning"
    ContactEmail = "n01538887@humbermail.ca"
    Environment  = "Lab"
  }
  humber_id = "n01538887"
}

module "resource_group" {
  source = "./modules/resource_group"
  # often chaning var
  rg_network_name = "rg_network"
  rg_linux_name   = "rg_linux"
  rg_windows_name = "rg_windows"
  rg_location     = "canadaeast"

  # local
  common_tags = local.common_tags
}

module "network" {
  source = "./modules/network"
  # sibling modules
  resource_group_name = module.resource_group.rg_network_name
  location            = module.resource_group.rg_network_location

  # often chaning var
  virtual_network_name          = "network-vnet"
  virtual_network_address_space = ["10.0.0.0/16"]
  subnet1_name                  = "network-subnet1"
  subnet1_address_space         = ["10.0.0.0/24"]
  subnet2_name                  = "network-subnet2"
  subnet2_address_space         = ["10.0.1.0/24"]
  network_security_group1_name  = "network-nsg1"
  network_security_group2_name  = "network-nsg2"
}

module "linux" {
  source = "./modules/linux"

  # sibling modules
  resource_group_name = module.resource_group.rg_linux_name
  location            = module.resource_group.rg_linux_location
  subnet1_id          = module.network.subnet1_id

  # often chaning var
  lvm_name = "${local.humber_id}-c-vm"
  size     = "Standard_B1s"
  os_disk_attributes = {
    storage_account_type = "Premium_LRS"
    disk_size            = 32
    caching              = "ReadWrite"
  }
  lvm_os_info = {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }
  lvm_as1 = {
    name                         = "${local.humber_id}-lvm-as1"
    platform_fault_domain_count  = 2
    platform_update_domain_count = 5
  }
  nb_count = 2

  # local
  common_tags = local.common_tags

}

module "windows" {
  source = "./modules/windows"

  # sibling modules
  wvm_resource_group_name = module.resource_group.rg_windows_name
  wvm_location            = module.resource_group.rg_windows_location
  subnet2_id              = module.network.subnet2_id

  # often chaning var
  wvm_name = {
    "n01538887-w-vm1" = "Standard_B1s"
  }

  wvm_os_info = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  wvm_os_profile = {
    admin_username = "winadm"
    admin_password = "Winadm!23"
  }

  wvm_as1 = {
    name                         = "wvm_as1"
    platform_fault_domain_count  = 2
    platform_update_domain_count = 5
  }

  wvm_os_disk_attributes = {
    storage_account_type = "Premium_LRS"
    disk_size            = 128
    caching              = "ReadWrite"
  }

  # local
  common_tags = local.common_tags


}

