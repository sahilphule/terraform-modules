resource "azurerm_storage_account" "storage-account" {
  resource_group_name = var.resource-group-properties.name
  location            = var.resource-group-properties.location

  name                          = var.storage-properties.storage-account.name
  account_tier                  = var.storage-properties.storage-account.tier
  account_kind                  = var.storage-properties.storage-account.kind
  account_replication_type      = var.storage-properties.storage-account.replication-type
  access_tier                   = var.storage-properties.storage-account.access-tier
  https_traffic_only_enabled    = var.storage-properties.storage-account.https-traffic-only-enabled
  public_network_access_enabled = var.storage-properties.storage-account.public-network-access-enabled
}

resource "azurerm_storage_account_network_rules" "storage-account-network-rules" {
  count = var.storage-properties.storage-account.network-rules-enabled ? 1 : 0

  storage_account_id = azurerm_storage_account.storage-account.id
  default_action     = var.storage-properties.storage-account.network-rules-properties.default-action
  bypass             = var.storage-properties.storage-account.network-rules-properties.bypass
  # ip_rules                   = [""]
  virtual_network_subnet_ids = var.vnet-subnet-ids
}

resource "azurerm_storage_container" "storage-container" {
  for_each = var.storage-properties.storage-container

  storage_account_id    = azurerm_storage_account.storage-account.id
  name                  = each.value.name
  container_access_type = each.value.container-access-type

  depends_on = [
    azurerm_storage_account.storage-account
  ]
}

# resource "azurerm_storage_blob" "storage-blob-object" {
#   name                   = var.storage-properties.sb-object-name
#   storage_account_name   = azurerm_storage_account.storage-account.name
#   storage_container_name = azurerm_storage_container.storage-container.name
#   type                   = var.storage-properties.sb-object-type
#   source                 = var.storage-properties.sb-object-source-path
# }
