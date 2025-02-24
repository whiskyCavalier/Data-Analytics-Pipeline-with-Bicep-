param location string
param resourceGroupName string
param projectName string
param environment string

var storageAccountName = 'st${projectName}${environment}'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-04-01' = {
  name: storageAccountName
  location: location
  resourceGroup: resourceGroupName
  sku: {
    name: 'Standard_GRS'
  }
  kind: 'StorageV2'
  properties: {
    isHnsEnabled: true // Enable hierarchical namespace (Data Lake)
    accessTier: 'Hot'
  }
}

output storageAccountName string = storageAccount.name