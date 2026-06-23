output "resource_group_name" {
  value = azurerm_resource_group.hub.name
}

output "vnet_id" {
  value = azurerm_virtual_network.hub.id
}
