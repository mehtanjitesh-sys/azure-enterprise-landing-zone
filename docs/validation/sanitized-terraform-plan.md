# Sanitized Terraform Plan Evidence

This file is an example of the type of sanitized plan output expected before production deployment. It intentionally does not include real tenant IDs, subscription IDs, object IDs, IP ranges, or secrets.

```text
Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create
  ~ update in-place

Plan: 34 to add, 0 to change, 0 to destroy.

Governance
  + azurerm_management_group.enterprise
  + azurerm_management_group.platform
  + azurerm_management_group.landing_zones
  + azurerm_policy_set_definition.enterprise_baseline
  + azurerm_management_group_policy_assignment.enterprise_baseline

RBAC
  + azurerm_role_assignment.platform_owners
  + azurerm_role_assignment.policy_admins
  + azurerm_role_assignment.security_readers

Management
  + azurerm_resource_group.management
  + azurerm_log_analytics_workspace.central
  + azurerm_monitor_action_group.platform
  + azurerm_consumption_budget_subscription.subscription

Security
  + azurerm_security_center_workspace.central
  + azurerm_security_center_subscription_pricing.defender_plans["VirtualMachines"]
  + azurerm_security_center_subscription_pricing.defender_plans["Containers"]
  + azurerm_security_center_subscription_pricing.defender_plans["StorageAccounts"]
  + azurerm_security_center_subscription_pricing.defender_plans["KeyVaults"]

Connectivity
  + azurerm_resource_group.hub
  + azurerm_virtual_network.hub
  + azurerm_subnet.firewall
  + azurerm_subnet.bastion
  + azurerm_subnet.private_dns_resolver

Application Landing Zone
  + azurerm_resource_group.app
  + azurerm_virtual_network.app
  + azurerm_subnet.aks_system
  + azurerm_subnet.aks_user
  + azurerm_log_analytics_workspace.app
  + azurerm_container_registry.app
  + azurerm_key_vault.app
  + azurerm_kubernetes_cluster.app
  + azurerm_kubernetes_cluster_node_pool.user
```

## Evidence Requirements

Before real deployment, attach:

- Terraform version
- Provider lock file
- Backend configuration
- Sanitized plan output
- Checkov/tfsec scan summary
- Bicep build result
- Manual approval record
- Rollback or remediation notes
