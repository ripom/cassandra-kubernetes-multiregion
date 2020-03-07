resource "azuread_application" "akscluster" {
  name                       = "akscluster"
  homepage                   = "http://akscluster"
  identifier_uris            = ["http://akscluster"]
  reply_urls                 = ["http://akscluster"]
  available_to_other_tenants = false
  oauth2_allow_implicit_flow = true
}

resource "azuread_service_principal" "akscluster" {
  application_id = azuread_application.akscluster.application_id
}

resource "azuread_service_principal_password" "akscluster" {
  service_principal_id = azuread_service_principal.akscluster.id
  value                = var.aks_client_secret
  end_date             = "2021-01-01T01:02:03Z"
}

resource "azuread_application" "dns-sidecar" {
name                       = "dns-sidecar"
homepage                   = "http://dns-sidecar"
identifier_uris            = ["http://dns-sidecar"]
reply_urls                 = ["http://dns-sidecar"]
available_to_other_tenants = false
  oauth2_allow_implicit_flow = true
}

resource "azuread_service_principal" "dns-sidecar" {
  application_id = azuread_application.dns-sidecar.application_id
}

resource "azuread_service_principal_password" "dns-sidecar" {
  service_principal_id = azuread_service_principal.dns-sidecar.id
  value                = var.aks_client_secret 
  end_date             = "2021-01-01T01:02:03Z"
}
