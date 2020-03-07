data "azurerm_subscription" "current" {
}

output "subscription_id" {
  value = data.azurerm_subscription.current.subscription_id
}

output "ResourceGroup" {
  value = var.infrastructure-rg
}

output "DnsZone" {
  value = var.dnszone_name
}

output "TENANT_ID" {
  value = data.azurerm_subscription.current.tenant_id
}

output "CLIENT" {
  value = azuread_application.dns-sidecar.application_id
}

output "KEY" {
  value = var.aks_client_secret
}
