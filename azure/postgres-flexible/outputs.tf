output "postgres-flexible-server-host" {
  description = "postgres flexible server host"
  value       = azurerm_postgresql_flexible_server.postgres-flexible-server.fqdn
}
