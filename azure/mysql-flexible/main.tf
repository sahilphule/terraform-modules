resource "azurerm_subnet" "mysql-flexible-vnet-subnet" {
  resource_group_name = var.resource-group-properties.name

  name                 = var.mysql-flexible-properties.mysql-flexible-vnet-subnet.name
  virtual_network_name = var.vnet-name
  address_prefixes     = var.mysql-flexible-properties.mysql-flexible-vnet-subnet.address-prefixes

  delegation {
    name = var.mysql-flexible-properties.mysql-flexible-vnet-subnet.delegation-name
    service_delegation {
      name    = var.mysql-flexible-properties.mysql-flexible-vnet-subnet.delegation-service-delegation-name
      actions = var.mysql-flexible-properties.mysql-flexible-vnet-subnet.delegation-service-delegation-actions
    }
  }
}

resource "azurerm_private_dns_zone" "mysql-flexible-private-dns-zone" {
  name                = var.mysql-flexible-properties.mysql-flexible-private-dns-zone.name
  resource_group_name = var.resource-group-properties.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "mysql-flexible-private-dns-zone-virtual-network-link" {
  resource_group_name = var.resource-group-properties.name

  name                  = var.mysql-flexible-properties.mysql-flexible-private-dns-zone.virtual-network-link-name
  private_dns_zone_name = azurerm_private_dns_zone.mysql-flexible-private-dns-zone.name
  virtual_network_id    = var.vnet-id

  depends_on = [
    azurerm_private_dns_zone.mysql-flexible-private-dns-zone
  ]
}

resource "azurerm_mysql_flexible_server" "mysql-flexible-server" {
  resource_group_name = var.resource-group-properties.name
  location            = var.resource-group-properties.location

  name                   = var.mysql-flexible-properties.mysql-flexible.server-name
  sku_name               = var.mysql-flexible-properties.mysql-flexible.sku-name
  version                = var.mysql-flexible-properties.mysql-flexible.version
  administrator_login    = var.mysql-flexible-properties.mysql-flexible.administrator-login
  administrator_password = var.mysql-flexible-properties.mysql-flexible.administrator-password
  backup_retention_days  = var.mysql-flexible-properties.mysql-flexible.backup-retention-days
  public_network_access  = var.mysql-flexible-properties.mysql-flexible.public-network-access

  delegated_subnet_id = azurerm_subnet.mysql-flexible-vnet-subnet.id
  private_dns_zone_id = azurerm_private_dns_zone.mysql-flexible-private-dns-zone.id

  storage {
    iops    = var.mysql-flexible-properties.mysql-flexible.storage-iops
    size_gb = var.mysql-flexible-properties.mysql-flexible.storage-size-gb
  }

  depends_on = [
    azurerm_subnet.mysql-flexible-vnet-subnet,
    azurerm_private_dns_zone.mysql-flexible-private-dns-zone
  ]
}
