locals {
  common_tags = {
    Name  = "Terraform-Class"
    Project = "Learning"
    ContactEmail = "n01538887@humbermail.ca"
    Environment = "Lab"
  }
}
variable "linux_name" {
  default = "n01538887-u-vm"
}

variable "size" {
  default = "Standard_B1s"
}

variable "admin_username" {
  default = "n01538887"
}

variable "public_key" {
  default = "~/.ssh/automation_rsa.pub"
}

variable "os_disk_attributes" {
  type = object({
    storage_account_type = string
    disk_size = number
    caching = string
  })
  default = {
    storage_account_type = "Premium_LRS"
    disk_size = 32
    caching = "ReadWrite"
  }
}

variable "ubuntu_linux_os_info" {
  type = object({
    publisher = string
    offer = string
    sku = string
    version = string
  })
  default = {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "19.04"
    version = "latest"
  }
}
variable "linux_avs" {
    type = object({
    name = string
    platform_fault_domain_count = number
    platform_update_domain_count = number
  })
  default = {                  
    name                        = "linux_avs"
    platform_fault_domain_count = 2
    platform_update_domain_count= 5
  }
}

variable "nb_count" {
  type        = number
  default     = 2
}
