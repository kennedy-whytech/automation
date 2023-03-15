variable "common_tags" {}

locals {
  common_tags = var.common_tags
}


variable "rg_network_name" {
  type    = string
  default = "rg_network"
}

variable "rg_linux_name" {
  type    = string
  default = "rg_linux"
}

variable "rg_windows_name" {
  type    = string
  default = "rg_windows"
}

variable "rg_location" {
  type    = string
  default = "canadaeast"
}
