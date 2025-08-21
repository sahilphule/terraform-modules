resource "azurerm_key_vault" "key-vault" {
  resource_group_name = var.resource-group-properties.name
  location            = var.resource-group-properties.location

  name     = var.key-vault-properties.key-vault.name
  sku_name = var.key-vault-properties.key-vault.sku-name

  soft_delete_retention_days    = var.key-vault-properties.key-vault.soft-delete-retention-days
  purge_protection_enabled      = var.key-vault-properties.key-vault.purge-protection-enabled
  public_network_access_enabled = var.key-vault-properties.key-vault.public-network-access-enabled
  enable_rbac_authorization     = var.key-vault-properties.key-vault.enable-rbac-authorization
  tenant_id                     = data.azurerm_client_config.client-config.tenant_id

  #   network_acls {
  #     default_action = "Deny"
  #     bypass         = "AzureServices"

  #     virtual_network_subnet_ids = [
  #       var.vnet-public-subnet-id
  #     ]
  #   }

  # lifecycle {
  #   ignore_changes = all
  # }
}

# resource "azurerm_key_vault_access_policy" "key-vault-access-policy" {
#   key_vault_id = azurerm_key_vault.key-vault.id
#   tenant_id    = data.azurerm_client_config.client-config.tenant_id
#   object_id    = data.azurerm_client_config.client-config.object_id

#   key_permissions = var.key-vault-properties.access-policy.key-permissions
#   secret_permissions = var.key-vault-properties.kv-access-policy.secret-permissions
# }
