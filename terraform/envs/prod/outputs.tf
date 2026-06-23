output "enterprise_management_group_id" {
  value = azurerm_management_group.enterprise.id
}

output "hub_resource_group_name" {
  value = module.network_hub.resource_group_name
}

output "aks_cluster_name" {
  value = module.aks_workload.aks_cluster_name
}

output "acr_name" {
  value = module.aks_workload.acr_name
}

output "central_log_analytics_workspace_id" {
  value = module.management_observability.central_log_analytics_workspace_id
}
