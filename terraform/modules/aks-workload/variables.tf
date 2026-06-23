variable "prefix" {
  type = string
}

variable "location" {
  type = string
}

variable "app_address_space" {
  type = list(string)
}

variable "aks_admin_group_id" {
  type = string
}
