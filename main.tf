terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.35.0"
    }
  }

  backend "azurerm" {
    access_key           = "VcMjtosDAwtdv4BFXjdFGxj6XPi0Je0zPFe8z1hpPzsS9C0V2xD/KI3fVufH9m8/bxpU1OsV86qG+AStXObyJw=="  # Can also be set via `ARM_ACCESS_KEY` environment variable.
    storage_account_name = "stgterraform098"                                 # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "blobtf"                                  # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "var.terraform.tfstate"                   # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "01202567-6e50-4f04-b07a-77bb79f043f9"
}

resource "azurerm_resource_group" "Resourcegroup" {
  name     = "${var.rgname}"
  location = "${var.rglocation}"
}

/*resource "azurerm_resource_group" "Resourcegroup01" {
  name     = "${var.rgname2}"
  location = "${var.rglocation2}"
}*/



