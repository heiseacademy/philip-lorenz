output "app_default_hostname" {
  description = "Hostname der Web App"
  value       = azurerm_app_service.app.default_site_hostname
}
