resource "azurerm_resource_group" "test" {
  name     = "blobstorage-website-rg"
  location = "japaneast"
}

resource "azurerm_storage_account" "test" {
  name                     = "${random_pet.test.id}${random_integer.test.result}"
  resource_group_name      = azurerm_resource_group.test.name
  location                 = azurerm_resource_group.test.location
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "LRS"

  static_website {
    index_document = "index.html"
  }
}

resource "azurerm_storage_blob" "test" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.test.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html" 
  source                 = "./src/index.html"
}

output "website_url" {
  value = azurerm_storage_account.test.primary_web_endpoint
}
