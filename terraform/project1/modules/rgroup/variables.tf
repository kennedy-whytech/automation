variable "common_tags" {}

locals {
  common_tags = var.common_tags
}

variable "rg1_name" {
  type = string
}

variable "rg1_location" {
  type    = string
  default = "canadaeast"
}
