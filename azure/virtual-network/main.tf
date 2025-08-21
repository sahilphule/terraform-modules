resource "azurerm_virtual_network" "virtual-network" {
  resource_group_name = var.resource-group-properties.name
  location            = var.resource-group-properties.location

  name          = var.virtual-network-properties.vnet-name
  address_space = var.virtual-network-properties.vnet-address-space
}

resource "azurerm_subnet" "virtual-network-subnet" {
  for_each            = var.virtual-network-properties.vnet-subnet-properties
  resource_group_name = var.resource-group-properties.name

  virtual_network_name = azurerm_virtual_network.virtual-network.name
  name                 = each.value.name
  address_prefixes     = each.value.address-prefixes
  service_endpoints    = lookup(each.value, "service-endpoints", null) == null ? [] : each.value.service-endpoints

  dynamic "delegation" {
    for_each = lookup(each.value, "delegation", null) == null ? [] : [each.value.delegation]
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service-delegation-name
        actions = delegation.value.service-delegation-actions
      }
    }
  }

  depends_on = [
    azurerm_virtual_network.virtual-network
  ]
}

resource "azurerm_network_security_group" "virtual-network-subnet-network-security-group" {
  for_each            = var.virtual-network-properties.vnet-subnet-properties
  resource_group_name = var.resource-group-properties.name
  location            = var.resource-group-properties.location

  name = each.value.network-security.group-name
}

resource "azurerm_network_security_rule" "virtual-network-subnet-network-security-group-rule" {
  for_each            = var.virtual-network-properties.vnet-subnet-properties
  resource_group_name = var.resource-group-properties.name

  network_security_group_name = azurerm_network_security_group.virtual-network-subnet-network-security-group[each.key].name

  name                       = each.value.network-security.rule-name
  priority                   = each.value.network-security.rule-priority
  direction                  = each.value.network-security.rule-direction
  access                     = each.value.network-security.rule-access
  protocol                   = each.value.network-security.rule-protocol
  source_port_range          = each.value.network-security.rule-source-port-range
  destination_port_range     = each.value.network-security.rule-destination-port-range
  source_address_prefix      = each.value.network-security.rule-source-address-prefix
  destination_address_prefix = each.value.network-security.rule-destination-address-prefix
}

resource "azurerm_subnet_network_security_group_association" "virtual-network-subnet-network-security-group-association" {
  for_each = var.virtual-network-properties.vnet-subnet-properties

  subnet_id                 = azurerm_subnet.virtual-network-subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.virtual-network-subnet-network-security-group[each.key].id
}
