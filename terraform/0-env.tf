variable "location1" {
  default = "westeurope"
}

variable "location2" {
  default = "southeastasia"
}

variable "nodeaks" {
  default = "3"
}

variable "sizeaks" {
  default = "Standard_DS2_v2"
}

variable "node_admin_username" {
  default = "xadmin"
}


variable "aks_client_secret" {
}

variable "infrastructure-rg" {
  
}

variable "environment" {
  default = "cdt"
}

variable "dnszone_name" {
  default = "cassandra.dse"
}

provider "azurerm" {
  version = "~> 1.44"
}

terraform {
  backend "local" {
  }
}

