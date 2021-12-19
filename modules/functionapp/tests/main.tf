locals {
  tags = {
    "BusinessArea"     = "example",
    "BusinessOwner"    = "example",
    "Description"      = "example",
    "SLA"              = "example",
    "TechnicalContact" = "example",
    "ServiceContact"   = "example",
    "OrderedBy"        = "example"
  }
}

resource "azurerm_resource_group" "this" {
  # this resource block is used for CI purposes only.
  # it verifies that the latest build of the module works
  # it is not actually deployed
  name     = "example-resourcegroup"
  location = "westeurope"
  tags     = local.tags
}

module "functionapp" {
  # this module block is used for CI purposes only.
  # it verifies that the latest build of the module works
  # it is not actually deployed

  source = "../." #I recommend you de-couple modules and templates by using ssh here

  function_app_name          = "example-functionapp"
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  enable_vnet                = false
  app_service_id             = "example"
  subnet_id                  = "example"
  app_service_plan_id        = "example"
  storage_account_name       = "example"
  storage_account_access_key = "example"
  keyvault_id                = "example"
  group_object_id            = "example"
  member_object_id           = module.functionapp.functionapp_principal_id

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "dotnet"
  }

  log_analytics_workspace_id = "example"
  application_insights_name  = "example-applicationinsights"

  tags = local.tags
}
