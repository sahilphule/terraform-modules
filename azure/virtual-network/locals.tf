locals {
  # resource group properties
  resource-group-properties = {}

  # virtual network properties
  virtual-network-properties = {
    vnet-name = "virtual-network"
    vnet-address-space = [
      "10.0.0.0/16"
    ]

    vnet-subnet-properties = {
      subnet-1 = {
        name              = "container-apps-vnet-subnet"
        address-prefixes  = ["10.0.0.0/23"]
        service-endpoints = ["Microsoft.Storage"]
        delegation = {
          name                       = "container-apps-delegation"
          service-delegation-name    = "Microsoft.App/environments"
          service-delegation-actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", ]
        }

        network-security = {
          group-name = "container-apps-vnet-subnet-nsg"

          rule-name                       = "AllowInternetIn"
          rule-priority                   = 100
          rule-direction                  = "Inbound"
          rule-access                     = "Allow"
          rule-protocol                   = "*"
          rule-source-port-range          = "*"
          rule-destination-port-range     = "*"
          rule-source-address-prefix      = "*"
          rule-destination-address-prefix = "*"
        }
      }

      subnet-2 = {
        name              = "mysql-flexible-server-vnet-subnet"
        address-prefixes  = ["10.0.2.0/23"]
        service-endpoints = ["Microsoft.Storage"]
        delegation = {
          name                       = "mysql-flexible-server-delegation"
          service-delegation-name    = "Microsoft.DBforMySQL/flexibleServers"
          service-delegation-actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", ]
        }

        nsg-name = "mysql-flexible-server-vnet-subnet-nsg"
        nsg-rule = {
          name                       = "DenyInternetIn"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Deny"
          protocol                   = "*"
          source-port-range          = "*"
          destination-port-range     = "*"
          source-address-prefix      = "*"
          destination-address-prefix = "*"
        }
      }
    }
  }
}
