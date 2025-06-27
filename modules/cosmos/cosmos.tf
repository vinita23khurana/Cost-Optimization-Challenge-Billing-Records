resource "azurerm_cosmosdb_account" "cosmos" {
  name                = "billing-cosmos-${random_string.rand.result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "MongoDB" # or "GlobalDocumentDB"
  enable_automatic_failover = true
  consistency_policy {
    consistency_level = "Session"
  }
}
# You'll add database, container, keys, throughput here…
