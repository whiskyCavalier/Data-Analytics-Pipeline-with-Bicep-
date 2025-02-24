param location string
param resourceGroupName string
param projectName string
param environment string

var workspaceName = 'db-${projectName}-${environment}'

resource databricksWorkspace 'Microsoft.Databricks/workspaces@2023-02-01' = {
  name: workspaceName
  location: location
  resourceGroup: resourceGroupName
  sku: {
    name: 'premium'
  }
  properties: {
    managedResourceGroupId: resourceGroupName
  }
}