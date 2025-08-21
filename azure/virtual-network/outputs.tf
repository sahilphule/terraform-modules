output "vnet-id" {
  description = "virtual network id"
  value       = azurerm_virtual_network.virtual-network.id
}

output "vnet-name" {
  description = "virtual network name"
  value       = azurerm_virtual_network.virtual-network.name
}

output "vnet-subnet-ids" {
  description = "virtual network public subnet ids"
  value       = values(azurerm_subnet.virtual-network-subnet)[*].id
}
