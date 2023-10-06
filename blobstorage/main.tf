locals {
  storage_accounts = {
    standard = {
      account_kind = "StorageV2"        # 一般的なアカウントタイプ
      account_tier = "Standard"         # 一般的なユースケースに適したタイプ(HDD)
    }
    premium = {
      account_kind = "BlockBlobStorage" # Block Blob専用のアカウントタイプ
      account_tier = "Premium"          # 高いI/O性能が必要なワークロードに適したタイプ(SSD)
    }
  }
}

resource "azurerm_resource_group" "test" {
  name     = "blobstorage-test-rg"
  location = "japaneast"
}

resource "azurerm_storage_account" "test" {
  for_each = local.storage_accounts

  name                     = "${random_pet.test.id}${random_integer.test.result}${each.key}"
  resource_group_name      = azurerm_resource_group.test.name
  location                 = azurerm_resource_group.test.location
  account_tier             = each.value["account_tier"] # Storage Accountのパフォーマンス層
  account_kind             = each.value["account_kind"] # Storage Accountの種類
  account_replication_type = "LRS"                      # Storage Accountの冗長性
}
