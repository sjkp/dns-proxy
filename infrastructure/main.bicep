targetScope = 'subscription'

param appName string
param location string
param containerImage string

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-${appName}'
  location: location
}

var storageAccountName = 'st${appName}'


module logs 'logs.bicep' = {
  scope: rg
  name: 'logs'
  params: {
    location: location 
    name: 'logs-${appName}'
  }
}



module aca 'aca.bicep' = {
  scope: rg
  name: 'azurecontainer'
  params: {
    lawClientId: logs.outputs.clientId
    lawClientSecret: logs.outputs.clientSecret
    location: location
    name: appName
    containerImage: containerImage
  }
}
