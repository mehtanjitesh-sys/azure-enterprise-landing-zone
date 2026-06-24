terraform {
  required_version = ">= 1.7.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.116"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.9"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

provider "azuread" {}
