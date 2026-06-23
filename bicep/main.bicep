targetScope = 'subscription'

param location string = 'eastus'
param prefix string = 'contoso'
param aksAdminGroupObjectId string

module network 'modules/network/hub.bicep' = {
  name: 'hub-network'
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
  params: {
    location: location
    prefix: prefix
    aksAdminGroupObjectId: aksAdminGroupObjectId
  }
}
