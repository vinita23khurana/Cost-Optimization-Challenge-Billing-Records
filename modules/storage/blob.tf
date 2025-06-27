resource "azurerm_storage_account" "acct" {
  name                     = "billingacct${random_string.rand.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "archive" {
  name                  = "billing-archive"
  storage_account_name  = azurerm_storage_account.acct.name
  container_access_type = "private"
}
