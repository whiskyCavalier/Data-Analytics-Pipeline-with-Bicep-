param location string
param resourceGroupName string
param storageAccountName string
param synapseWorkspaceName string
param powerBiServicePrincipalId string

// Grant Power BI SP access to Data Lake Storage
resource storageRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(storageAccountName, powerBiServicePrincipalId, 'Storage Blob Data Reader')
  scope: resource('Microsoft.Storage/storageAccounts', storageAccountName)
  properties: {
    principalId: powerBiServicePrincipalId
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', '2a2b9908-6ea1-4ae2-8e65-a410df84e7d1') // Storage Blob Data Reader
  }
}

// Grant Power BI SP access to Synapse workspace
resource synapseRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(synapseWorkspaceName, powerBiServicePrincipalId, 'Synapse SQL Administrator')
  scope: resource('Microsoft.Synapse/workspaces', synapseWorkspaceName)
  properties: {
    principalId: powerBiServicePrincipalId
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', '6e4bf58a-b8e1-4cc3-bbf9-d73143322b78') // Synapse SQL Administrator
  }
}