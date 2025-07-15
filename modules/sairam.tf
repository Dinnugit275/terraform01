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
    key                  = "module.terraform.tfstate"                   # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
}

provider "azurerm" {
  features {}
  subscription_id = "01202567-6e50-4f04-b07a-77bb79f043f9"
}



module "sairam" {

source ="C:/Terraform/modules"
rgname = "rg-tera"
rglocation = "East US"
vnetname = "vnetter"
vnet01_cidr_prefix = "10.2.0.0/16"
subnetname = "internal"
subnet01_cidr_prefix ="10.2.1.0/24"
nic-interfacename ="linux01-nic"
vmname01 = "linux01"
nsgname = "sainsg"
admin_name ="sairam"
admin_password ="msrCosmos12#"
publicipname_id = "vnamepublicip"
}