output "enabled_defender_resource_types" {
  value = keys(azurerm_security_center_subscription_pricing.defender_plans)
}
