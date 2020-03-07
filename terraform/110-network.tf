resource "azurerm_virtual_network" "vnet1" {
  resource_group_name = var.infrastructure-rg
  location            = var.location1
  name                = "${var.environment}-${var.location1}-vnet"

  address_space = ["172.16.0.0/16"]
}


resource "azurerm_subnet" "sn0-ingress1" {
  resource_group_name  = var.infrastructure-rg
  virtual_network_name = azurerm_virtual_network.vnet1.name
  name                 = "sn0-ingress"

  address_prefix = "172.16.0.0/24"

}
resource "azurerm_subnet" "sn1-frontend1" {
  resource_group_name  = var.infrastructure-rg
  virtual_network_name = azurerm_virtual_network.vnet1.name
  name                 = "sn1-frontend"

  address_prefix = "172.16.1.0/24"
  network_security_group_id = azurerm_network_security_group.AKS-loc1-NSG.id
  depends_on = [azurerm_network_security_group.AKS-loc1-NSG]
}

resource "azurerm_subnet" "sn2-backend1" {
  resource_group_name  = var.infrastructure-rg
  virtual_network_name = azurerm_virtual_network.vnet1.name
  name                 = "sn2-backend"

  address_prefix = "172.16.2.0/24"
  network_security_group_id = azurerm_network_security_group.AKS-loc1-NSG.id
  depends_on = [azurerm_network_security_group.AKS-loc1-NSG]
}

resource "azurerm_subnet" "sn3-devops1" {
  resource_group_name  = var.infrastructure-rg
  virtual_network_name = azurerm_virtual_network.vnet1.name
  name                 = "sn3-devops"

  address_prefix = "172.16.3.0/24"

}

# enable global peering between the two virtual network 
resource "azurerm_virtual_network_peering" "peering1" {
  name                         = "${var.environment}-${var.location1}-${var.location2}-vnet-peering"
  resource_group_name          = var.infrastructure-rg
  virtual_network_name         = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet2.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true

  # `allow_gateway_transit` must be set to false for vnet Global Peering
  allow_gateway_transit = false

  depends_on = [azurerm_virtual_network.vnet1]
  
}

resource "azurerm_virtual_network" "vnet2" {
  resource_group_name = var.infrastructure-rg
  location            = var.location2
  name                = "${var.environment}-${var.location2}-vnet"

  address_space = ["172.20.0.0/16"]
}


resource "azurerm_subnet" "sn0-ingress2" {
  resource_group_name  = var.infrastructure-rg
  virtual_network_name = azurerm_virtual_network.vnet2.name
  name                 = "sn0-ingress"

  address_prefix = "172.20.0.0/24"

}

resource "azurerm_subnet" "sn1-frontend2" {
  resource_group_name  = var.infrastructure-rg
  virtual_network_name = azurerm_virtual_network.vnet2.name
  name                 = "sn1-frontend"

  address_prefix = "172.20.1.0/24"
  network_security_group_id = azurerm_network_security_group.AKS-loc2-NSG.id
  depends_on = [azurerm_network_security_group.AKS-loc2-NSG]
}

resource "azurerm_subnet" "sn2-backend2" {
  resource_group_name  = var.infrastructure-rg
  virtual_network_name = azurerm_virtual_network.vnet2.name
  name                 = "sn2-backend"

  address_prefix = "172.20.2.0/24"
  network_security_group_id = azurerm_network_security_group.AKS-loc2-NSG.id
  depends_on = [azurerm_network_security_group.AKS-loc2-NSG]
}

resource "azurerm_subnet" "sn3-devops2" {
  resource_group_name  = var.infrastructure-rg
  virtual_network_name = azurerm_virtual_network.vnet2.name
  name                 = "sn3-devops"

  address_prefix = "172.20.3.0/24"
}

# enable global peering between the two virtual network 
resource "azurerm_virtual_network_peering" "peering2" {
  name                         = "${var.environment}-${var.location2}-${var.location1}-vnet-peering"
  resource_group_name          = var.infrastructure-rg
  virtual_network_name         = azurerm_virtual_network.vnet2.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet1.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true

  # `allow_gateway_transit` must be set to false for vnet Global Peering
  allow_gateway_transit = false

  depends_on = [azurerm_virtual_network.vnet2]

}

