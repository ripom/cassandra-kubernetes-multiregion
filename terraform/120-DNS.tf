resource "azurerm_private_dns_zone" "dnsdse" {
  name                = var.dnszone_name
  resource_group_name = var.infrastructure-rg

}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet1" {
  name                  = "vnet1link"
  resource_group_name   = var.infrastructure-rg
  private_dns_zone_name = azurerm_private_dns_zone.dnsdse.name
  virtual_network_id    = azurerm_virtual_network.vnet1.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet2" {
  name                  = "vnet2link"
  resource_group_name   = var.infrastructure-rg
  private_dns_zone_name = azurerm_private_dns_zone.dnsdse.name
  virtual_network_id    = azurerm_virtual_network.vnet2.id
}

resource "azurerm_role_assignment" "dns" {
  scope                = azurerm_private_dns_zone.dnsdse.id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azuread_service_principal.dns-sidecar.id 
}
