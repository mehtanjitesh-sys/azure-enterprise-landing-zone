output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.app.name
}

output "acr_name" {
  value = azurerm_container_registry.app.name
}
