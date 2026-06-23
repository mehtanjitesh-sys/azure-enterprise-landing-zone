variable "management_group_id" {
  type = string
}

variable "allowed_locations" {
  type = list(string)
}

variable "required_tag_names" {
  type = list(string)
}

variable "allowed_vm_skus" {
  type    = list(string)
  default = [
    "Standard_D2s_v5",
    "Standard_D4s_v5",
    "Standard_D8s_v5",
    "Standard_D4ds_v5",
    "Standard_D8ds_v5",
    "Standard_E4s_v5",
    "Standard_E8s_v5"
  ]
}

variable "deny_public_ip_effect" {
  type    = string
  default = "Deny"
}

variable "audit_effect" {
  type    = string
  default = "Audit"
}
