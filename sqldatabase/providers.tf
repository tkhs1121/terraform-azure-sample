terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "random_pet" "server" {
  length    = 1
  separator = ""
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#%"
  min_upper        = 5
  min_lower        = 5
  min_numeric      = 5
  min_special      = 1
}
