variable "common_tags" {}

locals {
  common_tags = var.common_tags
}


variable "lg_workspace_name" {
  type = string
}

variable "lg_workspace_retention_in_days" {
  type = number
}

variable "rs_vault_name" {
  type = string
}

variable "sa1_name" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "rg_location" {
  type = string
}
