param location string = 'eastus'
param projectName string = 'dataanalytics'
param environment string = 'prod'

param powerBiServicePrincipalId string = 'YOUR_POWERBI_SP_OBJECT_ID' // Replace with your SP object ID

resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: '${projectName}-${environment}-rg'
  location: location
}

module storage './modules/storage.bicep' = {
  name: 'storageDeployment'
  params: {
    location: location
    resourceGroupName: rg.name
    projectName: projectName
    environment: environment
  }
}

module databricks './modules/databricks.bicep' = {
  name: 'databricksDeployment'
  params: {
    location: location
    resourceGroupName: rg.name
    projectName: projectName
    environment: environment
  }
}

module synapse './modules/synapse.bicep' = {
  name: 'synapseDeployment'
  params: {
    location: location
    resourceGroupName: rg.name
    projectName: projectName
    environment: environment
    storageAccountName: storage.outputs.storageAccountName
  }
}

module powerbi './modules/powerbi.bicep' = {
  name: 'powerBiDeployment'
  params: {
    location: location
    resourceGroupName: rg.name
    storageAccountName: storage.outputs.storageAccountName
    synapseWorkspaceName: synapse.outputs.synapseWorkspaceName
    powerBiServicePrincipalId: powerBiServicePrincipalId
  }
}