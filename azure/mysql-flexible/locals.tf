locals {
  # resource group properties
  resource-group-properties = {}

  # vnet-id   = module.virtual-network.vnet-id
  # vnet-name = module.virtual-network.vnet-name

  # mysql flexible properties
  mysql-flexible-properties = {
    mysql-flexible-vnet-subnet = {
      name                                  = "mysql-flexible-server-vnet-subnet"
      address-prefixes                      = ["10.0.2.0/23"]
      delegation-name                       = "mysql-flexible-server-delegation"
      delegation-service-delegation-name    = "Microsoft.DBforMySQL/flexibleServers"
      delegation-service-delegation-actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", ]
    }

    mysql-flexible-private-dns-zone = {
      name                      = "privatelink.mysql.database.azure.com"
      virtual-network-link-name = "mysql-flexible-vnet-link"
    }

    mysql-flexible = {
      server-name            = "mysql-flexible-server"
      administrator-login    = ""
      administrator-password = ""
      version                = "8.0.21"
      sku-name               = "B_Standard_B1ms"
      backup-retention-days  = 7
      public-network-access  = "Enabled" # Enabled, Disabled
      storage-iops           = 360
      storage-size-gb        = 20
    }
  }
}
