data "azurerm_subscription" "current" {}

locals {
  tags = {
    Environment        = "prod"
    Owner              = "cloud-operations"
    CostCenter         = "platform"
    DataClassification = "internal"
    BusinessUnit       = "enterprise-it"
    Criticality        = "tier0"
    ManagedBy          = "terraform"
  }
}

resource "azurerm_resource_group" "management" {
  name     = "rg-${var.prefix}-management-prod"
  location = var.location
  tags     = local.tags
}

resource "azurerm_log_analytics_workspace" "central" {
  name                = "law-${var.prefix}-central-prod"
  location            = azurerm_resource_group.management.location
  resource_group_name = azurerm_resource_group.management.name
  sku                 = "PerGB2018"
  retention_in_days   = 365
  daily_quota_gb      = 100
  tags                = local.tags
}

resource "azurerm_monitor_action_group" "platform" {
  name                = "ag-${var.prefix}-platform-ops"
  resource_group_name = azurerm_resource_group.management.name
  short_name          = "platops"
  tags                = local.tags

  email_receiver {
    name          = "platform-operations"
    email_address = var.alert_email
  }
}

resource "azurerm_consumption_budget_subscription" "subscription" {
  name            = "budget-${var.prefix}-subscription-monthly"
  subscription_id = data.azurerm_subscription.current.id
  amount          = var.monthly_budget_amount
  time_grain      = "Monthly"

  time_period {
    start_date = "2026-07-01T00:00:00Z"
  }

  notification {
    enabled        = true
    threshold      = 80
    operator       = "GreaterThan"
    threshold_type = "Actual"
    contact_emails = [var.alert_email]
  }

  notification {
    enabled        = true
    threshold      = 100
    operator       = "GreaterThan"
    threshold_type = "Forecasted"
    contact_emails = [var.alert_email]
  }
}
