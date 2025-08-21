output "mysql-flexible-server-host" {
  description = "mysql flexible server host"
  value       = azurerm_mysql_flexible_server.mysql-flexible-server.fqdn
}
