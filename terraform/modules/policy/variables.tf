variable "management_group_id" {
  type = string
}

variable "allowed_locations" {
  type = list(string)
}

variable "required_tag_names" {
  type = list(string)
}
