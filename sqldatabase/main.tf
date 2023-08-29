resource "azurerm_resource_group" "test" {
  name     = "sql-db-rg"
  location = "japaneast"
}
 
resource "azurerm_mssql_server" "test" {
  name                         = "test-server"
  resource_group_name          = azurerm_resource_group.test.name
  location                     = azurerm_resource_group.test.location
  version                      = "12.0"
  administrator_login          = random_pet.server.id
  administrator_login_password = random_password.password.result
}
 
resource "azurerm_mssql_database" "test" {
  name                 = "test-db"
  server_id            = azurerm_mssql_server.test.id
  max_size_gb          = 2
  sku_name             = "P1"
  storage_account_type = "Local" # バックアップストレージのタイプ
}
