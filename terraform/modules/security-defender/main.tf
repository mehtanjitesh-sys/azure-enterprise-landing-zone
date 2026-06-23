data "azurerm_client_config" "current" {}

resource "azurerm_security_center_workspace" "central" {
  scope        = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  workspace_id = var.log_analytics_workspace_id
}

resource "azurerm_security_center_subscription_pricing" "defender_plans" {
  for_each      = var.enable_defender_plans ? var.defender_resource_types : toset([])
  tier          = "Standard"
  resource_type = each.key
}

resource "azurerm_security_center_setting" "mcas" {
  setting_name = "MCAS"
  enabled      = true
}

resource "azurerm_security_center_setting" "wdatp" {
  setting_name = "WDATP"
  enabled      = true
}

resource "azurerm_security_center_contact" "security" {
  email               = var.security_contact_email
  phone               = var.security_contact_phone
  alert_notifications = true
  alerts_to_admins    = true
}
