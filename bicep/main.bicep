targetScope = 'subscription'

param location string = 'eastus'
param prefix string = 'contoso'
param aksAdminGroupObjectId string

resource networkRg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'rg-${prefix}-hub-network'
  location: location
  tags: {
    Environment: 'prod'
    Owner: 'network-platform'
    CostCenter: 'platform'
    DataClassification: 'internal'
    BusinessUnit: 'enterprise-it'
  }
}

resource appRg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'rg-${prefix}-app001-prod'
  location: location
  tags: {
    Environment: 'prod'
    Owner: 'app001-team'
    CostCenter: 'app001'
    DataClassification: 'confidential'
    BusinessUnit: 'digital'
  }
}

module network 'modules/network/hub.bicep' = {
  name: 'hub-network'
  scope: networkRg
  params: {
    location: location
    prefix: prefix
  }
}

module governance 'modules/governance/policy.bicep' = {
  name: 'governance-policy'
  params: {
    allowedLocations: [
      'eastus'
      'eastus2'
      'centralus'
    ]
  }
}

module aks 'modules/aks/app001.bicep' = {
  name: 'app001-aks'
  scope: appRg
  params: {
    location: location
    prefix: prefix
    aksAdminGroupObjectId: aksAdminGroupObjectId
  }
}
