resource "azurerm_app_service_plan" "plan" {
  name                = "billing-func-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "FunctionApp"
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "func" {
  name                       = "billingFallbackFunc"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = azurerm_app_service_plan.plan.id
  storage_account_name       = var.storage_acct
  storage_account_access_key = var.storage_key
  version                    = "~4"
  app_settings = {
    "COSMOS_CONN"   = var.cosmos_account_string
    "BLOB_ACCOUNT"  = var.storage_account_name
    "BLOB_CONTAINER"= var.blob_container_name
  }
}
