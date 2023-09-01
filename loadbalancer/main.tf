resource "azurerm_resource_group" "test" {
  name     = "loadbalancer-test-rg"
  location = "japaneast"
}

resource "azurerm_public_ip" "test" {
  name                = "lb-public-ip"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "test" {
  name                = "test-loadbalancer"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                  = "test-public-ip-address"
    public_ip_address_id  = azurerm_public_ip.test.id
  }
}
