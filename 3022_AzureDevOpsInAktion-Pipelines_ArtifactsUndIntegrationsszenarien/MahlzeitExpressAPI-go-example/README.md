# App
## Install deps
go mod tidy

## Run
go run main.go

## Run Tests
go test -v

# Install Container Registry and Service Connection
## Login Azure CLI
az login

## Variablen anpassen
export ACR_NAME="heiseacademy"
export ACR_SKU="Basic"
export AZURE_RG="containers"

## Resource Group anlegen (falls noch nicht vorhanden)
az group create -n "$AZURE_RG" -l westeurope

## Container Registry anlegen
az acr create --resource-group "$AZURE_RG" --name "$ACR_NAME" --sku "$ACR_SKU"

## Service Conneciton anlegen
- In Azure DevOps auf Project Settings -> Service Connection
- "New Service Connection"
- "New Docker Registry service" -> "Azure Container Registry"
- Werte eingeben
