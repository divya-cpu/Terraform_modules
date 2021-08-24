resource "azurerm_storage_account" "sa" {
  name                = "sadivyssss"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  #   account_kind              = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"


  # static_website {
  #   index_document     = "index.html"
  #   error_404_document = "error.html"
  # }

  tags = {
    created_by = var.tag
  }
}

resource "azurerm_storage_container" "example" {
  name                  = "tfstates"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}