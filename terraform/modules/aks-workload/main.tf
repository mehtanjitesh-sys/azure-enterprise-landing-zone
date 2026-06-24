locals {
  tags = {
    Environment        = "prod"
    Owner              = "app001-team"
    CostCenter         = "app001"
    DataClassification = "confidential"
    BusinessUnit       = "digital"
    Criticality        = "tier1"
    ManagedBy          = "terraform"
  }
}

resource "azurerm_resource_group" "app" {
  name     = "rg-${var.prefix}-app001-prod"
  location = var.location

  tags = local.tags
}

resource "azurerm_virtual_network" "app" {
  name                = "vnet-${var.prefix}-app001-prod"
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name
  address_space       = var.app_address_space
  tags                = local.tags
}

resource "azurerm_subnet" "aks_system" {
  name                 = "snet-aks-system"
  resource_group_name  = azurerm_resource_group.app.name
  virtual_network_name = azurerm_virtual_network.app.name
  address_prefixes     = ["10.10.0.0/22"]
}

resource "azurerm_subnet" "aks_user" {
  name                 = "snet-aks-user"
  resource_group_name  = azurerm_resource_group.app.name
  virtual_network_name = azurerm_virtual_network.app.name
  address_prefixes     = ["10.10.4.0/22"]
}

resource "azurerm_log_analytics_workspace" "app" {
  name                = "law-${var.prefix}-app001-prod"
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name
  sku                 = "PerGB2018"
  retention_in_days   = 90
  tags                = local.tags
}

resource "azurerm_container_registry" "app" {
  name                = replace("acr${var.prefix}app001prod", "-", "")
  resource_group_name = azurerm_resource_group.app.name
  location            = azurerm_resource_group.app.location
  sku                 = "Premium"
  admin_enabled       = false
  tags                = local.tags
}

resource "azurerm_key_vault" "app" {
  name                       = substr("kv-${var.prefix}-app001-prod", 0, 24)
  location                   = azurerm_resource_group.app.location
  resource_group_name        = azurerm_resource_group.app.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "premium"
  purge_protection_enabled   = true
  soft_delete_retention_days = 90
  enable_rbac_authorization  = true
  tags                       = local.tags
}

data "azurerm_client_config" "current" {}

resource "azurerm_kubernetes_cluster" "app" {
  name                      = "aks-${var.prefix}-app001-prod"
  location                  = azurerm_resource_group.app.location
  resource_group_name       = azurerm_resource_group.app.name
  dns_prefix                = "aks-${var.prefix}-app001-prod"
  kubernetes_version        = null
  private_cluster_enabled   = true
  oidc_issuer_enabled       = true
  workload_identity_enabled = true
  tags                      = local.tags

  default_node_pool {
    name                         = "system"
    vm_size                      = "Standard_D4ds_v5"
    vnet_subnet_id               = azurerm_subnet.aks_system.id
    zones                        = ["1", "2", "3"]
    enable_auto_scaling          = true
    min_count                    = 3
    max_count                    = 6
    orchestrator_version         = null
    only_critical_addons_enabled = true
  }

  identity {
    type = "SystemAssigned"
  }

  azure_active_directory_role_based_access_control {
    managed                = true
    azure_rbac_enabled     = true
    admin_group_object_ids = [var.aks_admin_group_id]
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.app.id
  }

  key_vault_secrets_provider {
    secret_rotation_enabled  = true
    secret_rotation_interval = "2m"
  }

  azure_policy_enabled = true

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
    outbound_type     = "userDefinedRouting"
  }

  auto_scaler_profile {
    balance_similar_node_groups    = true
    expander                       = "least-waste"
    max_graceful_termination_sec   = "600"
    scale_down_delay_after_add     = "10m"
    scale_down_delay_after_delete  = "10s"
    scale_down_delay_after_failure = "3m"
    scan_interval                  = "10s"
    skip_nodes_with_local_storage  = false
    skip_nodes_with_system_pods    = true
  }
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = azurerm_container_registry.app.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.app.kubelet_identity[0].object_id
}

resource "azurerm_kubernetes_cluster_node_pool" "user" {
  name                  = "user"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.app.id
  vm_size               = "Standard_D8ds_v5"
  vnet_subnet_id        = azurerm_subnet.aks_user.id
  zones                 = ["1", "2", "3"]
  mode                  = "User"
  enable_auto_scaling   = true
  min_count             = 3
  max_count             = 20
  max_pods              = 50

  node_labels = {
    workload = "app001"
  }

  tags = local.tags
}
