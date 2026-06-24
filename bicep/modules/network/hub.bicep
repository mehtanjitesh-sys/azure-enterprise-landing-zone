targetScope = 'resourceGroup'

param location string
param prefix string

resource hub 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: 'vnet-${prefix}-hub'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'AzureFirewallSubnet'
        properties: {
          addressPrefix: '10.0.0.0/26'
        }
      }
      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: '10.0.0.64/26'
        }
      }
      {
        name: 'snet-private-dns-resolver'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}
