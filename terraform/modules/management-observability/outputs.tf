output "management_resource_group_name" {
  value = azurerm_resource_group.management.name
}

output "central_log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.central.id
}

output "platform_action_group_id" {
  value = azurerm_monitor_action_group.platform.id
}
