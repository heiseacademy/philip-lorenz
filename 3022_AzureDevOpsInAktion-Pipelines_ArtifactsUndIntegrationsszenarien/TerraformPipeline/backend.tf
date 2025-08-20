terraform {
  backend "azurerm" {
    storage_account_name = "mahlzeitstatestore"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_azuread_auth     = false
  }
}
