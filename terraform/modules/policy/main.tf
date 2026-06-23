locals {
  policy_category = "Enterprise Landing Zone"
}

resource "azurerm_policy_definition" "allowed_locations" {
  name                = "custom-allowed-locations"
  policy_type         = "Custom"
  mode                = "All"
  display_name        = "Allowed Azure locations"
  management_group_id = var.management_group_id

  metadata = jsonencode({
    category = local.policy_category
  })

  parameters = jsonencode({
    allowedLocations = {
      type = "Array"
      metadata = {
        displayName = "Allowed locations"
      }
    }
  })

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field = "location"
          notIn = "[parameters('allowedLocations')]"
        },
        {
          field = "location"
          notEquals = "global"
        }
      ]
    }
    then = {
      effect = "Deny"
    }
  })
}

resource "azurerm_policy_definition" "require_tags" {
  for_each            = toset(var.required_tag_names)
  name                = "custom-require-tag-${lower(each.key)}"
  policy_type         = "Custom"
  mode                = "Indexed"
  display_name        = "Require tag ${each.key}"
  management_group_id = var.management_group_id

  metadata = jsonencode({
    category = local.policy_category
  })

  policy_rule = jsonencode({
    if = {
      field  = "tags['${each.key}']"
      exists = "false"
    }
    then = {
      effect = "Deny"
    }
  })
}

resource "azurerm_policy_definition" "deny_public_ip" {
  name                = "custom-deny-public-ip"
  policy_type         = "Custom"
  mode                = "All"
  display_name        = "Deny public IP addresses"
  management_group_id = var.management_group_id

  metadata = jsonencode({
    category = local.policy_category
  })

  parameters = jsonencode({
    effect = {
      type = "String"
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue = "Deny"
    }
  })

  policy_rule = jsonencode({
    if = {
      field  = "type"
      equals = "Microsoft.Network/publicIPAddresses"
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
}

resource "azurerm_policy_definition" "deny_storage_public_blob" {
  name                = "custom-deny-storage-public-blob"
  policy_type         = "Custom"
  mode                = "Indexed"
  display_name        = "Deny storage accounts that allow public blob access"
  management_group_id = var.management_group_id

  metadata = jsonencode({
    category = local.policy_category
  })

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field  = "type"
          equals = "Microsoft.Storage/storageAccounts"
        },
        {
          field     = "Microsoft.Storage/storageAccounts/allowBlobPublicAccess"
          notEquals = "false"
        }
      ]
    }
    then = {
      effect = "Deny"
    }
  })
}

resource "azurerm_policy_definition" "require_storage_secure_transfer" {
  name                = "custom-require-storage-secure-transfer"
  policy_type         = "Custom"
  mode                = "Indexed"
  display_name        = "Require secure transfer for storage accounts"
  management_group_id = var.management_group_id

  metadata = jsonencode({
    category = local.policy_category
  })

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field  = "type"
          equals = "Microsoft.Storage/storageAccounts"
        },
        {
          field     = "Microsoft.Storage/storageAccounts/supportsHttpsTrafficOnly"
          notEquals = "true"
        }
      ]
    }
    then = {
      effect = "Deny"
    }
  })
}

resource "azurerm_policy_definition" "require_key_vault_soft_delete" {
  name                = "custom-require-key-vault-soft-delete"
  policy_type         = "Custom"
  mode                = "Indexed"
  display_name        = "Require Key Vault soft delete"
  management_group_id = var.management_group_id

  metadata = jsonencode({
    category = local.policy_category
  })

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field  = "type"
          equals = "Microsoft.KeyVault/vaults"
        },
        {
          field     = "Microsoft.KeyVault/vaults/enableSoftDelete"
          notEquals = "true"
        }
      ]
    }
    then = {
      effect = "Deny"
    }
  })
}

resource "azurerm_policy_definition" "audit_key_vault_purge_protection" {
  name                = "custom-audit-key-vault-purge-protection"
  policy_type         = "Custom"
  mode                = "Indexed"
  display_name        = "Audit Key Vaults without purge protection"
  management_group_id = var.management_group_id

  metadata = jsonencode({
    category = local.policy_category
  })

  parameters = jsonencode({
    effect = {
      type = "String"
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue = "Audit"
    }
  })

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field  = "type"
          equals = "Microsoft.KeyVault/vaults"
        },
        {
          field     = "Microsoft.KeyVault/vaults/enablePurgeProtection"
          notEquals = "true"
        }
      ]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
}

resource "azurerm_policy_definition" "audit_aks_private_cluster" {
  name                = "custom-audit-aks-private-cluster"
  policy_type         = "Custom"
  mode                = "Indexed"
  display_name        = "Audit AKS clusters without private API server"
  management_group_id = var.management_group_id

  metadata = jsonencode({
    category = local.policy_category
  })

  parameters = jsonencode({
    effect = {
      type = "String"
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue = "Audit"
    }
  })

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field  = "type"
          equals = "Microsoft.ContainerService/managedClusters"
        },
        {
          field     = "Microsoft.ContainerService/managedClusters/apiServerAccessProfile.enablePrivateCluster"
          notEquals = "true"
        }
      ]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
}

resource "azurerm_policy_definition" "audit_aks_azure_policy" {
  name                = "custom-audit-aks-azure-policy-addon"
  policy_type         = "Custom"
  mode                = "Indexed"
  display_name        = "Audit AKS clusters without Azure Policy add-on"
  management_group_id = var.management_group_id

  metadata = jsonencode({
    category = local.policy_category
  })

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field  = "type"
          equals = "Microsoft.ContainerService/managedClusters"
        },
        {
          field     = "Microsoft.ContainerService/managedClusters/addonProfiles.azurepolicy.enabled"
          notEquals = "true"
        }
      ]
    }
    then = {
      effect = "Audit"
    }
  })
}

resource "azurerm_policy_definition" "allowed_vm_skus" {
  name                = "custom-allowed-vm-skus"
  policy_type         = "Custom"
  mode                = "Indexed"
  display_name        = "Allowed virtual machine SKUs"
  management_group_id = var.management_group_id

  metadata = jsonencode({
    category = local.policy_category
  })

  parameters = jsonencode({
    allowedVmSkus = {
      type = "Array"
      metadata = {
        displayName = "Allowed VM SKUs"
      }
    }
  })

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field  = "type"
          equals = "Microsoft.Compute/virtualMachines"
        },
        {
          field = "Microsoft.Compute/virtualMachines/sku.name"
          notIn = "[parameters('allowedVmSkus')]"
        }
      ]
    }
    then = {
      effect = "Deny"
    }
  })
}

resource "azurerm_policy_set_definition" "enterprise_baseline" {
  name                = "enterprise-landing-zone-baseline"
  policy_type         = "Custom"
  display_name        = "Enterprise Landing Zone Baseline"
  management_group_id = var.management_group_id

  metadata = jsonencode({
    category = local.policy_category
  })

  parameters = jsonencode({
    allowedLocations = {
      type = "Array"
    }
    allowedVmSkus = {
      type = "Array"
    }
    denyPublicIpEffect = {
      type = "String"
      allowedValues = ["Audit", "Deny", "Disabled"]
    }
    auditEffect = {
      type = "String"
      allowedValues = ["Audit", "Deny", "Disabled"]
    }
  })

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.allowed_locations.id
    parameter_values = jsonencode({
      allowedLocations = {
        value = "[parameters('allowedLocations')]"
      }
    })
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.deny_public_ip.id
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('denyPublicIpEffect')]"
      }
    })
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.deny_storage_public_blob.id
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.require_storage_secure_transfer.id
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.require_key_vault_soft_delete.id
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.audit_key_vault_purge_protection.id
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('auditEffect')]"
      }
    })
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.audit_aks_private_cluster.id
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('auditEffect')]"
      }
    })
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.audit_aks_azure_policy.id
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.allowed_vm_skus.id
    parameter_values = jsonencode({
      allowedVmSkus = {
        value = "[parameters('allowedVmSkus')]"
      }
    })
  }
}

resource "azurerm_management_group_policy_assignment" "enterprise_baseline" {
  name                 = "enterprise-baseline"
  display_name         = "Enterprise Landing Zone Baseline"
  management_group_id  = var.management_group_id
  policy_definition_id = azurerm_policy_set_definition.enterprise_baseline.id

  parameters = jsonencode({
    allowedLocations = {
      value = var.allowed_locations
    }
    allowedVmSkus = {
      value = var.allowed_vm_skus
    }
    denyPublicIpEffect = {
      value = var.deny_public_ip_effect
    }
    auditEffect = {
      value = var.audit_effect
    }
  })
}

resource "azurerm_management_group_policy_assignment" "required_tags" {
  for_each             = azurerm_policy_definition.require_tags
  name                 = "require-${replace(lower(each.key), " ", "-")}"
  display_name         = "Require tag ${each.key}"
  management_group_id  = var.management_group_id
  policy_definition_id = each.value.id
}
