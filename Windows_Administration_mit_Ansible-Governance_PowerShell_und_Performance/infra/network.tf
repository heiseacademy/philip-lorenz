resource "azurerm_resource_group" "lab" {
  name     = "ansible-kurs-rg"
  location = var.location
}

resource "azurerm_virtual_network" "lab" {
  name                = "ansible-kurs-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
}

resource "azurerm_subnet" "lab" {
  name                 = "ansible-kurs-subnet"
  resource_group_name  = azurerm_resource_group.lab.name
  virtual_network_name = azurerm_virtual_network.lab.name
  address_prefixes     = ["10.0.1.0/24"]
}
