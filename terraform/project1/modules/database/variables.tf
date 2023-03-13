variable "common_tags" {}

locals {
  common_tags = var.common_tags
}
variable "rg_name" {
  type = string
}

variable "rg_location" {
  type = string
}

variable "database_instance_name" {
  type = string
}

variable "administrator_login" {
  type = string
}

variable "administrator_login_password" {
  type = string
}

variable "sku_name" {
  type = string
}

variable "storage_mb" {
  type = number
}

variable "backup_retention_days" {
  type = number
}

variable "geo_redundant_backup_enabled" {
  type = bool
}

variable "auto_grow_enabled" {
  type = bool
}

variable "db_version" {
  type = string
}

variable "ssl_enforcement_enabled" {
  type = bool
}
