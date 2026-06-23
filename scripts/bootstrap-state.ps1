param(
  [Parameter(Mandatory = $true)]
  [string]$ResourceGroupName,

  [Parameter(Mandatory = $true)]
  [string]$StorageAccountName,

  [string]$Location = "eastus",
  [string]$ContainerName = "tfstate"
)

az group create --name $ResourceGroupName --location $Location
az storage account create `
  --name $StorageAccountName `
  --resource-group $ResourceGroupName `
  --location $Location `
  --sku Standard_GRS `
  --kind StorageV2 `
  --https-only true `
  --min-tls-version TLS1_2 `
  --allow-blob-public-access false

az storage account blob-service-properties update `
  --account-name $StorageAccountName `
  --resource-group $ResourceGroupName `
  --enable-versioning true `
  --enable-delete-retention true `
  --delete-retention-days 30

az storage container create `
  --name $ContainerName `
  --account-name $StorageAccountName `
  --auth-mode login
