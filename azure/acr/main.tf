resource "azurerm_container_registry" "acr" {
  resource_group_name = var.resource-group-properties.name
  location            = var.resource-group-properties.location

  name                          = var.acr-properties.name
  sku                           = var.acr-properties.sku
  admin_enabled                 = var.acr-properties.admin-enabled
  public_network_access_enabled = var.acr-properties.public-network-access-enabled
}
