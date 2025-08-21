resource "azurerm_subnet" "postgres-flexible-vnet-subnet" {
  resource_group_name = var.resource-group-properties.name

  name                 = var.postgres-flexible-properties.postgres-flexible-vnet-subnet.name
  virtual_network_name = var.vnet-name
  address_prefixes     = var.postgres-flexible-properties.postgres-flexible-vnet-subnet.address-prefixes

  delegation {
    name = var.postgres-flexible-properties.postgres-flexible-vnet-subnet.delegation-name
    service_delegation {
      name    = var.postgres-flexible-properties.postgres-flexible-vnet-subnet.delegation-service-delegation-name
      actions = var.postgres-flexible-properties.postgres-flexible-vnet-subnet.delegation-service-delegation-actions
    }
  }
}

resource "azurerm_private_dns_zone" "postgres-flexible-private-dns-zone" {
  name                = var.postgres-flexible-properties.postgres-flexible-private-dns-zone.name
  resource_group_name = var.resource-group-properties.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgres-flexible-private-dns-zone-virtual-network-link" {
  resource_group_name = var.resource-group-properties.name

  name                  = var.postgres-flexible-properties.postgres-flexible-private-dns-zone.virtual-network-link-name
  private_dns_zone_name = azurerm_private_dns_zone.postgres-flexible-private-dns-zone.name
  virtual_network_id    = var.vnet-id

  depends_on = [
    azurerm_subnet.postgres-flexible-vnet-subnet
  ]
}

resource "azurerm_postgresql_flexible_server" "postgres-flexible-server" {
  resource_group_name = var.resource-group-properties.name
  location            = var.resource-group-properties.location

  name                          = var.postgres-flexible-properties.postgres-flexible-server.name
  sku_name                      = var.postgres-flexible-properties.postgres-flexible-server.sku-name
  version                       = var.postgres-flexible-properties.postgres-flexible-server.version
  administrator_login           = var.postgres-flexible-properties.postgres-flexible-server.administrator-login
  administrator_password        = var.postgres-flexible-properties.postgres-flexible-server.administrator-password
  storage_mb                    = var.postgres-flexible-properties.postgres-flexible-server.storage-mb
  storage_tier                  = var.postgres-flexible-properties.postgres-flexible-server.storage-tier
  backup_retention_days         = var.postgres-flexible-properties.postgres-flexible-server.backup-retention-days
  zone                          = var.postgres-flexible-properties.postgres-flexible-server.zone
  public_network_access_enabled = var.postgres-flexible-properties.postgres-flexible-server.public-network-access-enabled

  delegated_subnet_id = azurerm_subnet.postgres-flexible-vnet-subnet.id
  private_dns_zone_id = azurerm_private_dns_zone.postgres-flexible-private-dns-zone.id

  dynamic "high_availability" {
    for_each = var.postgres-flexible-properties.postgres-flexible-server.enable-postgres-high-availability-mode ? [1] : []
    content {
      mode = var.postgres-flexible-properties.postgres-flexible-server-high-availability-mode
    }
  }

  depends_on = [
    azurerm_subnet.postgres-flexible-vnet-subnet,
    azurerm_private_dns_zone.postgres-flexible-private-dns-zone
  ]
}
