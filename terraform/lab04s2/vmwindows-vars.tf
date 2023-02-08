variable "windows_os_info" {
  type = object({
    publisher = string
    offer = string
    sku = string
    version = string
  })
  default = {
    publisher = "MicrosoftWindowsServer"
    offer = "WindowsServer"
    sku = "2016-Datacenter"
    version = "latest"
  }
}

variable "windows_name" {
  type = map(string)

  default = {
    "n01538887-w-vm1" = "Standard_B1s"
    "n01538887-w-vm2" = "Standard_B1ms"
  }
}

variable "windows_avs" {
    type = object({
    name = string
    platform_fault_domain_count = number
    platform_update_domain_count = number
  })
  default = {                  
    name                        = "windows_avs"
    platform_fault_domain_count = 2
    platform_update_domain_count= 5
  }
}

variable "windows_os_profile" {
  type = object({
    admin_username = string
    admin_password = string
  })
  default = {
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }
}

variable "windows_os_disk_attributes" {
  type = object({
    storage_account_type = string
    disk_size = number
    caching = string
  })
  default = {
    storage_account_type = "Premium_LRS"
    disk_size = 128
    caching = "ReadWrite"
  }
}
