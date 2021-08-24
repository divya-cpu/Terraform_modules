terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }

  backend "azurerm" {
    resource_group_name  = "akgr-terraform-rg"
    storage_account_name = "akgrmsvs001"
    container_name       = "tf-state"
    key                  = "dev.terraform.tfstate-002"
  }

}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}