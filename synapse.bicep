param location string
param resourceGroupName string
param projectName string
param environment string
param storageAccountName string

var synapseWorkspaceName = 'synapse-${projectName}-${environment}'
var sqlPoolName = 'sqlpool${projectName}${environment}'

resource synapseWorkspace 'Microsoft.Synapse/workspaces@2021-06-01' = {
  name: synapseWorkspaceName
  location: location
  resourceGroup: resourceGroupName
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    defaultDataLakeStorage: {
      accountName: storageAccountName
      filesystem: 'synapsefs'
    }
    sqlAdministratorLogin: 'synapseadmin'
    sqlAdministratorLoginPassword: 'P@ssw0rd123!' // Use Key Vault in production
  }
}

resource sqlPool 'Microsoft.Synapse/workspaces/sqlPools@2021-06-01' = {
  name: sqlPoolName
  parent: synapseWorkspace
  location: location
  sku: {
    name: 'DW100c'
  }
}

output synapseWorkspaceName string = synapseWorkspace.name