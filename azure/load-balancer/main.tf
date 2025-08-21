resource "azurerm_lb" "lb" {
  resource_group_name = var.resource-group-properties.name
  location            = var.resource-group-properties.location

  name = var.lb-properties.lb-name
  sku  = var.lb-properties.lb-sku

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.example.id
  }
}
