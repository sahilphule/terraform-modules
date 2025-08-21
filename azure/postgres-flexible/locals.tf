locals {
  # resource group properties
  resource-group-properties = {}

  # vnet-id   = module.virtual-network.vnet-id
  # vnet-name = module.virtual-network.vnet-name

  # postgres flexible properties
  postgres-flexible-properties = {
    postgres-flexible-vnet-subnet = {
      name                                  = "postgres-flexible-server-vnet-subnet"
      address-prefixes                      = ["10.0.2.0/23"]
      delegation-name                       = "postgres-flexible-server-delegation"
      delegation-service-delegation-name    = "Microsoft.DBforPostgreSQL/flexibleServers"
      delegation-service-delegation-actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", ]
    }

    postgres-flexible-private-dns-zone = {
      name                      = "private.postgres.database.azure.com"
      virtual-network-link-name = "postgres-flexible-vnet-link"
    }

    postgres-flexible-server = {
      name                          = "postgres-flexible-server"
      administrator-login           = ""
      administrator-password        = ""
      version                       = "12"
      sku-name                      = "B_Standard_B1ms"
      storage-mb                    = 32768
      storage-tier                  = "P4"
      backup-retention-days         = 7
      zone                          = "1"
      public-network-access-enabled = false

      enable-postgres-high-availability-mode = false
      high-availability-mode                 = "SameZone" # SameZone, "ZoneRedundant"
    }
  }
}
