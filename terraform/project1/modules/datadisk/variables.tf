variable "common_tags" {}

locals {
  common_tags = var.common_tags
}

variable "rg_location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "storage_account_type" {
  type = string
}

variable "disk_size_gb" {
  type = number
}

variable "vm_ids" {
  type = list(string)
}

variable "vm_names" {
  type = list(string)
}

variable "disk_name" {
  type = string
}
