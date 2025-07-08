
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.35.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "01202567-6e50-4f04-b07a-77bb79f043f9"
}

# create a Resource group

resource "azurerm_resource_group" "Resourcegroup" {
  name     = "rg-terr"
  location = "East US"
}

# create a vnet
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-terr"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.Resourcegroup.location
  resource_group_name = azurerm_resource_group.Resourcegroup.name
}

# create a subnet
resource "azurerm_subnet" "subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.Resourcegroup.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage"]
}

# create a storage account 
resource "azurerm_storage_account" "stg" {
  name                = "stgterraform12306"
  resource_group_name = azurerm_resource_group.Resourcegroup.name
  location                 = azurerm_resource_group.Resourcegroup.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action             = "Allow"
    ip_rules                   = ["100.0.0.1"]
    virtual_network_subnet_ids = [azurerm_subnet.subnet.id]
  }

  tags = {
    Deploy= "terraform"
    environment = "Non-prod"
  }
}
# create a blob storage 
resource "azurerm_storage_container" "blob01" {
  name                  = "blobtest"
  storage_account_id    = azurerm_storage_account.stg.id
  container_access_type = "private"
}
# Create a recovery service vault

resource "azurerm_recovery_services_vault" "Rsv-vault" {
  name                          = "rsv-trr"
  location                      = "eastus"
  resource_group_name           = "rg-terr"
  sku                           = "Standard"
  storage_mode_type             = "LocallyRedundant"  # <--- Changed to LRS
  soft_delete_enabled           = false
  public_network_access_enabled = true
  cross_region_restore_enabled  = false
}

# configure a backup for blob account in storage account 

resource "azurerm_backup_container_storage_account" "backup-container" {
  resource_group_name = azurerm_resource_group.Resourcegroup.name
  recovery_vault_name = azurerm_recovery_services_vault.Rsv-vault.name
  storage_account_id  = azurerm_storage_account.stg.id
}
