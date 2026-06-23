variable "prefix" {
  type = string
}

variable "location" {
  type = string
}

variable "alert_email" {
  type        = string
  description = "Email address for initial platform alerts."
}

variable "monthly_budget_amount" {
  type        = number
  description = "Monthly budget threshold for the current subscription."
  default     = 5000
}
