# Author: Roberth Lombardi
# Company: Molnbolaget
# CreationDate: 2021-12-19
# Description:
# This module will create a function app, along with vnet connection and application insights.
# It will also connect the application insights connection string and instrumentation key to the functions app settings.
# There's built-in functions for allowing the function to communicate with a keyvault via Azure AD group.

resource "azurerm_function_app" "this" {
  name                       = var.function_app_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = var.app_service_plan_id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  version                    = "~3"
  app_settings               = merge(var.app_settings, { "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.this.connection_string }, { "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.this.instrumentation_key })
  # Above setting merges application insights connection string and instrumentation key with var.app_settings

  identity {
    type = "SystemAssigned"

  }
  site_config {
    vnet_route_all_enabled = var.enable_vnet
    always_on              = true
    http2_enabled          = true

  }


  tags = var.tags
}

resource "azurerm_app_service_virtual_network_swift_connection" "this" {
  count = var.enable_vnet != false ? 1 : 0
  # above count creates a vnet connection for function app if var.enable_vnet = true

  app_service_id = azurerm_function_app.this.id
  subnet_id      = var.subnet_id
}

resource "azurerm_application_insights" "this" {
  name                = var.application_insights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  workspace_id        = var.log_analytics_workspace_id
  application_type    = "web"

  tags = var.tags
}

resource "azuread_group_member" "this" {
  #can be used to give function app access to key vault via azure ad groups.
  group_object_id  = var.group_object_id
  member_object_id = azurerm_function_app.functionapp.identity.0.principal_id
}
