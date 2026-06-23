variable "platform_management_group" {
  type = string
}

variable "landing_zone_group" {
  type = string
}

variable "group_object_ids" {
  type = object({
    platform_owners  = string
    policy_admins    = string
    network_admins   = string
    security_readers = string
    app_devops       = string
    aks_admins       = string
  })
}
