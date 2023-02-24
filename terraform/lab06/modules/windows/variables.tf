variable "common_tags" {}

locals {
  common_tags = var.common_tags
}


variable "wvm_os_info" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

variable "wvm_name" {
  type = map(string)
}

variable "wvm_os_profile" {
  type = object({
    admin_username = string
    admin_password = string
  })
}

variable "wvm_as1" {
  type = object({
    name                         = string
    platform_fault_domain_count  = number
    platform_update_domain_count = number
  })
}

variable "wvm_os_disk_attributes" {
  type = object({
    storage_account_type = string
    disk_size            = number
    caching              = string
  })
}

variable "wvm_location" {
  type = string
}

variable "wvm_resource_group_name" {
  type = string
}

variable "subnet2_id" {
  type = string
}
