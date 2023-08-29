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

resource "random_integer" "test" {
  min = 1
  max = 100
}

resource "random_pet" "test" {
  length    = 1
  separator = ""
}
