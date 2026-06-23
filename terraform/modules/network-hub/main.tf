locals {
  tags = {
    Environment        = "prod"
    Owner              = "network-platform"
    CostCenter         = "platform"
    DataClassification = "internal"
    BusinessUnit       = "enterprise-it"
    Criticality        = "tier0"
    ManagedBy          = "terraform"
  }
}

resource "azurerm_resource_group" "hub" {
  name     = "rg-${var.prefix}-hub-network"
  location = var.location

  tags = local.tags
}

resource "azurerm_virtual_network" "hub" {
  name                = "vnet-${var.prefix}-hub"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  address_space       = var.hub_address_space
  tags                = local.tags
}

resource "azurerm_subnet" "firewall" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.0.0.0/26"]
}

resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.0.0.64/26"]
}

resource "azurerm_subnet" "private_dns_resolver" {
  name                 = "snet-private-dns-resolver"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.0.1.0/24"]
}
