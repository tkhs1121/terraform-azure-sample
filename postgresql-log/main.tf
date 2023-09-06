resource "azurerm_resource_group" "test" {
  name     = "postgresql-test-rg"
  location = "japaneast"
}

resource "azurerm_postgresql_server" "test" {
  name                             = "postgresql-server-${random_pet.server.id}-${random_integer.test.result}"
  location                         = azurerm_resource_group.test.location
  resource_group_name              = azurerm_resource_group.test.name
  sku_name                         = "B_Gen5_2"                      # SKU (Basic, General Purpose, Memory Optimized)
  storage_mb                       = 5120                            # ストレージの容量(MB)
  backup_retention_days            = 7                               # バックアップ保持日数
  geo_redundant_backup_enabled     = false                           # Geo 冗長サーバーのバックアップの有効化
  auto_grow_enabled                = false                           # ストレージの自動拡張の有効化
  administrator_login              = random_pet.server.id            # 管理者ID
  administrator_login_password     = random_password.password.result # 管理者パスワード               
  version                          = "11"                            # PostgreSQL Serverのバージョン
  ssl_enforcement_enabled          = false                           # SSL接続を強制するか
  ssl_minimal_tls_version_enforced = "TLSEnforcementDisabled"        # サポートするSSLの最小バージョン
  public_network_access_enabled    = true                            # パブリックアクセスの有効化
}

resource "azurerm_postgresql_configuration" "debug_print_plan" {
  name                = "debug_print_plan"
  resource_group_name = azurerm_resource_group.test.name
  server_name         = azurerm_postgresql_server.test.name
  value               = "on"
}

resource "azurerm_postgresql_configuration" "debug_print_parse" {
  name                = "debug_print_parse"
  resource_group_name = azurerm_resource_group.test.name
  server_name         = azurerm_postgresql_server.test.name
  value               = "on"
}

resource "azurerm_postgresql_configuration" "debug_print_rewritten" {
  name                = "debug_print_rewritten"
  resource_group_name = azurerm_resource_group.test.name
  server_name         = azurerm_postgresql_server.test.name
  value               = "on"
}
