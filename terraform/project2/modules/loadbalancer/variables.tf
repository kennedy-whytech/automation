variable "rg_name" {
  type = string
}

variable "rg_location" {
  type = string
}

variable "subnet1_id" {
  type = string
}

variable "backend_pool_name" {
  type = string
}

variable "frontend_ip_configuration_name" {
  type = string
}

variable "lb_name" {
  type = string
}

variable "backend_port" {
  type = number
}

variable "frontend_port" {
  type = number
}

variable "lb_sku" {
  type = string
}

variable "network_vnet_id" {
  type = string
}

# variable "lvm_nic1_ids" {
#   type = list(string)
# }

# variable "wvm_nic1_ids" {
#   type = list(string)
# }


variable "lvm_private_ips" {
  type = list(string)
}

# variable "wvm_private_ips" {
#   type = list(string)
# }