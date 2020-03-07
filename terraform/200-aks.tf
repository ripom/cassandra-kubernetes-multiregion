resource "tls_private_key" "aksnode-sshkey" {
  algorithm   = "RSA"
  rsa_bits    = "2048"
}

resource "azurerm_kubernetes_cluster" "aksloc1" {
  name                = "${var.environment}-aks-${var.location1}"
  location            = var.location1
  resource_group_name = var.infrastructure-rg
  dns_prefix          = "${var.environment}-aks-${var.location1}"
  kubernetes_version  = "1.14.8"

  linux_profile {
    admin_username = var.node_admin_username

    ssh_key {
      key_data = tls_private_key.aksnode-sshkey.public_key_openssh
    }
  }

  default_node_pool {
    name                  = "default"
    node_count            = var.nodeaks
    vnet_subnet_id        = azurerm_subnet.sn1-frontend1.id
    vm_size               = var.sizeaks
    os_disk_size_gb       = 30
  }

  service_principal {
    client_id     = azuread_application.akscluster.application_id 
    client_secret = var.aks_client_secret
  }
  network_profile {
    network_plugin = "azure"
  }
  role_based_access_control {

    enabled = true

  }
  depends_on = [azuread_service_principal_password.akscluster]
}

resource "azurerm_kubernetes_cluster_node_pool" "aksloc1-pool1" {
  name                  = "internal"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aksloc1.id
  node_count            = var.nodeaks
  vnet_subnet_id        = azurerm_subnet.sn1-frontend1.id
  vm_size               = var.sizeaks
  os_type               = "Linux"
  os_disk_size_gb       = 30
}
resource "azurerm_kubernetes_cluster" "aksloc2" {
  name                = "${var.environment}-aks-${var.location2}"
  location            = var.location2
  resource_group_name = var.infrastructure-rg
  dns_prefix          = "${var.environment}-aks-${var.location2}"
  kubernetes_version  = "1.14.8"

  linux_profile {
    admin_username = var.node_admin_username

    ssh_key {
      key_data = tls_private_key.aksnode-sshkey.public_key_openssh
    }
  }

  default_node_pool {
    name                  = "default"
    node_count            = var.nodeaks
    vnet_subnet_id        = azurerm_subnet.sn1-frontend2.id
    vm_size               = var.sizeaks
    os_disk_size_gb       = 30
  }

  service_principal {
    client_id     = azuread_application.akscluster.application_id
    client_secret = var.aks_client_secret
  }
  network_profile {
    network_plugin = "azure"
  }
  role_based_access_control {

    enabled = true

  }
  depends_on = [azuread_service_principal_password.akscluster]
}

resource "azurerm_kubernetes_cluster_node_pool" "aksloc2-pool1" {
  name                  = "internal"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aksloc2.id
  node_count            = var.nodeaks
  vnet_subnet_id        = azurerm_subnet.sn1-frontend2.id
  vm_size               = var.sizeaks
  os_type               = "Linux"
  os_disk_size_gb       = 30
}
