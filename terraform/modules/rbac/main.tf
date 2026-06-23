resource "azurerm_role_assignment" "platform_owners" {
  scope                = var.platform_management_group
  role_definition_name = "Owner"
  principal_id         = var.group_object_ids.platform_owners
}

resource "azurerm_role_assignment" "policy_admins" {
  scope                = var.platform_management_group
  role_definition_name = "Resource Policy Contributor"
  principal_id         = var.group_object_ids.policy_admins
}

resource "azurerm_role_assignment" "security_readers" {
  scope                = var.landing_zone_group
  role_definition_name = "Security Reader"
  principal_id         = var.group_object_ids.security_readers
}

resource "azurerm_role_assignment" "app_devops" {
  scope                = var.landing_zone_group
  role_definition_name = "Contributor"
  principal_id         = var.group_object_ids.app_devops
}
