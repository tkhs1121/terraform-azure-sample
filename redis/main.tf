resource "azurerm_resource_group" "test" {
  name     = "redis-rg"
  location = "japaneast"
}

resource "azurerm_virtual_network" "test" {
  name                = "test-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
}

resource "azurerm_subnet" "test" {
  name                 = "test-subnet"
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes     = ["10.0.2.0/24"]
}
 
resource "azurerm_redis_cache" "test" {
  name                = "test-redis-cache-${random_pet.test.id}-${random_integer.test.result}"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  subnet_id           = azurerm_subnet.test.id
  enable_non_ssl_port = true      # 非TLSポートの有効化
  family              = "P"       # 価格タイプ, C(Basic/Standard), P(Premium)
  capacity            = 1         # Redisキャッシュのサイズ
  sku_name            = "Premium" # SKU(Basic, Standard, Premium)
  shard_count         = 3         # Premiumのみ使用可能, シャードの数
}
