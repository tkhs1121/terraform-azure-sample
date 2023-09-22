locals {
  sku_name = {
    "basic" = "B_Gen5_2"  # Basic、Gen 5、および 2 個の仮想コア
  }
}

resource "azurerm_resource_group" "test" {
  name     = "mysql-test-rg"
  location = "japaneast"
}

resource "azurerm_mysql_server" "master" {
  for_each = local.sku_name

  name                              = "mysql-server-${each.key}-${random_pet.server.id}-${random_integer.test.result}"
  location                          = azurerm_resource_group.test.location
  resource_group_name               = azurerm_resource_group.test.name
  sku_name                          = each.value                      # SKU (Basic, General Purpose, Memory Optimized)
  storage_mb                        = 102400                          # ストレージの容量(MB)
  backup_retention_days             = 7                               # バックアップ保持日数
  geo_redundant_backup_enabled      = false                           # Geo 冗長サーバーのバックアップの有効化
  auto_grow_enabled                 = false                           # ストレージの自動拡張の有効化
  administrator_login               = random_pet.server.id            # 管理者ID
  administrator_login_password      = random_password.password.result # 管理者パスワード
  version                           = "8.0"                           # PostgreSQL Serverのバージョン
  ssl_enforcement_enabled           = false                           # SSL接続を強制するか
  ssl_minimal_tls_version_enforced  = "TLSEnforcementDisabled"        # サポートするSSLの最小バージョン
  public_network_access_enabled     = true                            # パブリックアクセスの有効化
}

resource "azurerm_mysql_configuration" "log_queries_not_using_indexes" {
  for_each = local.sku_name

  name                = "log_queries_not_using_indexes"
  resource_group_name = azurerm_mysql_server.master[each.key].resource_group_name
  server_name         = azurerm_mysql_server.master[each.key].name
  value               = "ON"
}

resource "azurerm_mysql_configuration" "slow_query_log" {
  for_each = local.sku_name

  name                = "slow_query_log"
  resource_group_name = azurerm_mysql_server.master[each.key].resource_group_name
  server_name         = azurerm_mysql_server.master[each.key].name
  value               = "ON"
}

resource "azurerm_mysql_configuration" "long_query_time" {
  for_each = local.sku_name

  name                = "long_query_time"
  resource_group_name = azurerm_mysql_server.master[each.key].resource_group_name
  server_name         = azurerm_mysql_server.master[each.key].name
  value               = "0"
}
