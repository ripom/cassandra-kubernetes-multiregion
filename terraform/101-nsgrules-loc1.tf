resource "azurerm_network_security_rule" "CassandraDB-fe1" {
  name                        = "CassandraDB-fe1"
  priority                    = 1000
  direction                   = "Intbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "9042"
  source_address_prefix       = "172.16.1.0/24"
  destination_address_prefix  = "*"
  resource_group_name         = var.infrastructure-rg
  network_security_group_name = azurerm_network_security_group.AKS-loc1-NSG.name
}

