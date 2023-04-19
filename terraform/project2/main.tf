locals {
  common_tags = {
    Project        = "Automation Project – Assignment 2"
    GroupMembers   = "kennedy.yau"
    ExpirationDate = "2023-06-30"
    Environment    = "Lab"
  }
  humber_id = "ken8887"
}

module "rgroup" {
  source = "./modules/rgroup"

  # often chaning var
  rg1_name     = "${local.humber_id}-assignment2-RG"
  rg1_location = "canadaeast"

  # local
  common_tags = local.common_tags
}

module "network" {
  source = "./modules/network"

  # sibling modules
  rg_name     = module.rgroup.rg1_name
  rg_location = module.rgroup.rg1_location

  # often chaning var
  virtual_network_name          = "${local.humber_id}-network-vnet"
  virtual_network_address_space = ["10.0.0.0/16"]
  subnet1_name                  = "${local.humber_id}-network-subnet1"
  subnet1_address_space         = ["10.0.0.0/24"]
  network_security_group1_name  = "${local.humber_id}-network-nsg1"
}

module "common" {
  source = "./modules/common"

  # sibling modules
  rg_name     = module.rgroup.rg1_name
  rg_location = module.rgroup.rg1_location

  # often chaning var
  lg_workspace_name              = "${local.humber_id}-lg-workspace"
  lg_workspace_retention_in_days = 30

  rs_vault_name = "${local.humber_id}-rsvault"

  sa1_name = "${local.humber_id}sa1"

  # local
  common_tags = local.common_tags
}


module "linux" {
  source = "./modules/linux"

  # sibling modules
  rg_name             = module.rgroup.rg1_name
  rg_location         = module.rgroup.rg1_location
  subnet1_id          = module.network.subnet1_id
  storage_account_uri = module.common.sa1_primary_blob_endpoint
  sa1_id              = module.common.sa1_obj.id
  vndda_obj           = module.datadisk.vndda_obj

  # often chaning var
  lvm_name = "${local.humber_id}-c-vm"
  size     = "Standard_B1ms"
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
  rg_name             = module.rgroup.rg1_name
  rg_location         = module.rgroup.rg1_location
  subnet1_id          = module.network.subnet1_id
  storage_account_uri = module.common.sa1_primary_blob_endpoint

  # often chaning var
  wvm_name = {
    "${local.humber_id}-w-vm1" = "Standard_B1s"
    #"${local.humber_id}-w-vm2" = "Standard_B1ms"
  }

  wvm_os_info = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  wvm_os_profile = {
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }

  wvm_as1 = {
    name                         = "${local.humber_id}-wvm-as1"
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

module "datadisk" {
  source = "./modules/datadisk"

  # sibling modules
  rg_name     = module.rgroup.rg1_name
  rg_location = module.rgroup.rg1_location
  vm_ids      = concat(module.linux.lvm_ids, module.windows.wvm_ids) # attach managed disk to each vm
  vm_names    = concat(module.linux.lvm_names, module.windows.wvm_names)
  lvm_obj     = module.linux.lvm_obj
  depends_on = [
    module.common.sa1_obj,
    module.linux.lvm_obj,
    module.windows.wvm_obj
  ]

  # often chaning var
  disk_size_gb         = 10
  storage_account_type = "Standard_LRS"
  disk_name            = "disk0"

  # local
  common_tags = local.common_tags
}

module "loadbalancer" {
  source = "./modules/loadbalancer"

  # sibling modules
  rg_name         = module.rgroup.rg1_name
  rg_location     = module.rgroup.rg1_location
  network_vnet_id = module.network.network_vnet_id
  lvm_private_ips = module.linux.lvm_private_ips
  # wvm_private_ips = module.windows.wvm_private_ips
  subnet1_id = module.network.subnet1_id

  # often chaning var
  backend_pool_name              = "${local.humber_id}-backend_pool"
  frontend_ip_configuration_name = "${local.humber_id}-frontend_ip_configuration"
  lb_name                        = "${local.humber_id}-public-lb"
  lb_sku                         = "Standard" # the sku type will be shared by public ip
  backend_port                   = 80
  frontend_port                  = 80
}

module "database" {
  source = "./modules/database"

  # sibling modules
  rg_name     = module.rgroup.rg1_name
  rg_location = module.rgroup.rg1_location

  # often chaning var
  sku_name                     = "B_Gen5_2"
  database_instance_name       = "${local.humber_id}-db"
  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true
  administrator_login          = "psqladmin"
  administrator_login_password = "H@Sh1CoR3!"
  db_version                   = "9.5"
  ssl_enforcement_enabled      = true

  # local
  common_tags = local.common_tags
}