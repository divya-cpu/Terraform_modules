
resource "azurerm_resource_group" "rg" {
  name     = var.rg-name
  location = "West Europe"
}

module "network" {
  source = "./modules/network"

  name          = var.name
  address_space = var.address_space
  tag           = var.tag
  location      = azurerm_resource_group.rg.location
  rg            = azurerm_resource_group.rg.name
  subnet1_space = var.subnet1_space
  env = var.env


}



