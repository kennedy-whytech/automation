variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "virtual_network_address_space" {
  type = list(string)
}

variable "subnet1_name" {
  type = string
}

variable "subnet1_address_space" {
  type = list(string)
}

variable "subnet2_name" {
  type = string
}

variable "subnet2_address_space" {
  type = list(string)
}

variable "network_security_group1_name" {
  type = string
}

variable "network_security_group2_name" {
  type = string
}
