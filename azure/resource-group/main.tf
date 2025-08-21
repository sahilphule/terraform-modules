resource "azurerm_resource_group" "resource-group" {
  location = var.resource-group-properties.location
  name     = var.resource-group-properties.name
}
