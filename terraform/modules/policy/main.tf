resource "azurerm_policy_definition" "allowed_locations" {
  name                = "custom-allowed-locations"
  policy_type         = "Custom"
  mode                = "All"
  display_name        = "Allowed Azure locations"
  management_group_id = var.management_group_id

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

resource "azurerm_management_group_policy_assignment" "allowed_locations" {
  name                 = "allowed-locations"
  display_name         = "Allowed Azure locations"
  management_group_id  = var.management_group_id
  policy_definition_id = azurerm_policy_definition.allowed_locations.id

  parameters = jsonencode({
    allowedLocations = {
      value = var.allowed_locations
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
