resource "azurerm_network_security_rule" "CassandraDB-fe2" {
  name                        = "CassandraDB-fe2"
  priority                    = 1000
  direction                   = "Intbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "9042"
  source_address_prefix       = "172.20.1.0/24"
  destination_address_prefix  = "*"
  resource_group_name         = var.infrastructure-rg
  network_security_group_name = azurerm_network_security_group.AKS-loc2-NSG.name
}
