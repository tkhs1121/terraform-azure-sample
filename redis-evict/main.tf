resource "azurerm_resource_group" "test" {
  name     = "redis-rg"
  location = "japaneast"
}
 
resource "azurerm_redis_cache" "test" {
  name                = "test-redis-cache-${random_pet.test.id}-${random_integer.test.result}"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  capacity            = 1          # Redisキャッシュのサイズ
  family              = "C"        # 価格タイプ, C(Basic/Standard), P(Premium)
  sku_name            = "Standard" # SKU(Basic, Standard, Premium)
  enable_non_ssl_port = true       # 非TLSポートの有効化

  redis_configuration {
    maxmemory_policy   = "allkeys-random"
    maxmemory_reserved = 755
  }
}

output "redis_host_name" {
  value = azurerm_redis_cache.test.hostname
}

output "redis_access_key" {
  sensitive = true
  value     = azurerm_redis_cache.test.primary_access_key
}
