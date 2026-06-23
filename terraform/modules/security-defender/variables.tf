variable "log_analytics_workspace_id" {
  description = "Central Log Analytics workspace used for Defender and security operations."
  type        = string
}

variable "enable_defender_plans" {
  description = "Enable Microsoft Defender for Cloud paid plans for production baseline."
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

variable "defender_resource_types" {
  description = "Defender for Cloud resource types to enable at subscription scope."
  type        = set(string)
  default = [
    "VirtualMachines",
    "Containers",
    "StorageAccounts",
    "KeyVaults",
    "AppServices",
    "SqlServers",
    "SqlServerVirtualMachines",
    "Arm"
  ]
}
