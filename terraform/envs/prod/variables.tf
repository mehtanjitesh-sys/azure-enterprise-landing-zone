variable "tenant_root_id" {
  description = "Root management group ID for the enterprise landing zone."
  type        = string
}

variable "location" {
  description = "Primary Azure region."
  type        = string
  default     = "eastus"
}

variable "allowed_locations" {
  description = "Allowed Azure deployment regions."
  type        = list(string)
  default     = ["eastus", "eastus2", "centralus"]
}

variable "prefix" {
  description = "Naming prefix."
  type        = string
  default     = "entlz"
}

variable "platform_group_object_ids" {
  description = "Entra group object IDs used for platform RBAC."
  type = object({
    platform_owners  = string
    policy_admins    = string
    network_admins   = string
    security_readers = string
    app_devops       = string
    aks_admins       = string
  })
}

variable "address_space" {
  description = "Network address spaces."
  type = object({
    hub_vnet = list(string)
    app_vnet = list(string)
  })
  default = {
    hub_vnet = ["10.0.0.0/16"]
    app_vnet = ["10.10.0.0/16"]
  }
}

variable "platform_alert_email" {
  description = "Email address for initial platform operations alerts."
  type        = string
}

variable "monthly_budget_amount" {
  description = "Initial monthly budget amount for the subscription."
  type        = number
  default     = 5000
}

variable "enable_defender_plans" {
  description = "Enable Microsoft Defender for Cloud paid plans for the production baseline."
  type        = bool
  default     = true
}

variable "security_contact_email" {
  description = "Security operations email used for Defender for Cloud notifications."
  type        = string
}

variable "security_contact_phone" {
  description = "Security operations phone number used for Defender for Cloud notifications."
  type        = string
  default     = "+1-555-0100"
}
