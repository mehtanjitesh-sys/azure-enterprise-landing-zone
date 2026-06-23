data "azurerm_client_config" "current" {}

resource "azurerm_management_group" "enterprise" {
  display_name = var.tenant_root_id
  name         = var.tenant_root_id
}

resource "azurerm_management_group" "platform" {
  display_name               = "platform"
  name                       = "${var.tenant_root_id}-platform"
  parent_management_group_id = azurerm_management_group.enterprise.id
}

resource "azurerm_management_group" "landing_zones" {
  display_name               = "landing-zones"
  name                       = "${var.tenant_root_id}-landing-zones"
  parent_management_group_id = azurerm_management_group.enterprise.id
}

resource "azurerm_management_group" "corp" {
  display_name               = "corp"
  name                       = "${var.tenant_root_id}-corp"
  parent_management_group_id = azurerm_management_group.landing_zones.id
}

resource "azurerm_management_group" "online" {
  display_name               = "online"
  name                       = "${var.tenant_root_id}-online"
  parent_management_group_id = azurerm_management_group.landing_zones.id
}

module "policy" {
  source               = "../../modules/policy"
  management_group_id  = azurerm_management_group.enterprise.id
  allowed_locations    = var.allowed_locations
  required_tag_names   = ["CostCenter", "Environment", "Owner", "DataClassification", "BusinessUnit", "Criticality", "ManagedBy"]
}

module "rbac" {
  source                    = "../../modules/rbac"
  platform_management_group = azurerm_management_group.platform.id
  landing_zone_group        = azurerm_management_group.landing_zones.id
  group_object_ids          = var.platform_group_object_ids
}

module "network_hub" {
  source              = "../../modules/network-hub"
  prefix              = var.prefix
  location            = var.location
  hub_address_space   = var.address_space.hub_vnet
}

module "management_observability" {
  source                = "../../modules/management-observability"
  prefix                = var.prefix
  location              = var.location
  alert_email           = var.platform_alert_email
  monthly_budget_amount = var.monthly_budget_amount
}

module "aks_workload" {
  source            = "../../modules/aks-workload"
  prefix            = var.prefix
  location          = var.location
  app_address_space = var.address_space.app_vnet
  aks_admin_group_id = var.platform_group_object_ids.aks_admins
}
