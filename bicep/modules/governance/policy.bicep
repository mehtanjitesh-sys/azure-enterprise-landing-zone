targetScope = 'subscription'

param allowedLocations array

resource allowedLocationsPolicy 'Microsoft.Authorization/policyDefinitions@2023-04-01' = {
  name: 'custom-allowed-locations'
  properties: {
    displayName: 'Allowed Azure locations'
    policyType: 'Custom'
    mode: 'All'
    parameters: {
      allowedLocations: {
        type: 'Array'
        metadata: {
          displayName: 'Allowed locations'
        }
      }
    }
    policyRule: json('''
      {
        "if": {
          "allOf": [
            {
              "field": "location",
              "notIn": "[parameters('allowedLocations')]"
            },
            {
              "field": "location",
              "notEquals": "global"
            }
          ]
        },
        "then": {
          "effect": "Deny"
        }
      }
    ''')
  }
}

resource allowedLocationsAssignment 'Microsoft.Authorization/policyAssignments@2024-04-01' = {
  name: 'allowed-locations'
  properties: {
    displayName: 'Allowed Azure locations'
    policyDefinitionId: allowedLocationsPolicy.id
    parameters: {
      allowedLocations: {
        value: allowedLocations
      }
    }
  }
}
