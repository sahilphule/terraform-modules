resource "azurerm_service_plan" "service-plan" {
  resource_group_name = var.resource-group-properties.name
  location            = var.resource-group-properties.location

  name     = var.service-plan-properties.name
  os_type  = var.service-plan-properties.os-type
  sku_name = var.service-plan-properties.sku-name
}
