resource "azurerm_network_security_group" "AKS-loc1-NSG" {
  name                = "${var.environment}-${var.location1}-aks-fe-nsg"
  location            = var.location1
  resource_group_name = var.infrastructure-rg
}

resource "azurerm_network_security_group" "AKS-loc2-NSG" {
  name                = "${var.environment}-${var.location2}-aks-fe-nsg"
  location            = var.location2
  resource_group_name = var.infrastructure-rg
}
