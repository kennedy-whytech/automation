variable "common_tags" {}

locals {
  common_tags = var.common_tags
}


variable "lvm_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "size" {
  type = string
}

variable "admin_username" {
  type    = string
  default = "n01538887"
}

variable "public_key" {
  type    = string
  default = "~/.ssh/automation_rsa.pub"
}

variable "private_key" {
  type    = string
  default = "~/.ssh/automation_rsa"
}

variable "os_disk_attributes" {
  type = object({
    storage_account_type = string
    disk_size            = number
    caching              = string
  })
}

variable "ubuntu_lvm_os_info" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "19.04"
    version   = "latest"
  }
}

variable "lvm_as1" {
  type = object({
    name                         = string
    platform_fault_domain_count  = number
    platform_update_domain_count = number
  })
}

variable "nb_count" {
  type = number
}

variable "subnet1_id" {
  type = string
}