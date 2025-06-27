provider "azurerm" {
  features {}
}

module "cosmos" {
  source              = "./modules/cosmos"
  resource_group_name = azurerm_resource_group.rg.name
}

module "storage" {
  source              = "./modules/storage"
  resource_group_name = azurerm_resource_group.rg.name
}

module "function_app" {
  source                = "./modules/function"
  resource_group_name   = azurerm_resource_group.rg.name
  storage_account_name  = module.storage.account_name
  blob_container_name   = module.storage.container_name
  cosmos_account_string = module.cosmos.connection_string
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group
  location = var.location
}
