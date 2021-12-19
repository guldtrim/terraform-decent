# --- General
variable "location" {
  type        = string
  default     = "westeurope"
  description = "Location of Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the target resource group"
}

variable "tags" {
  type = map(any)
}

# --- Function app
variable "function_app_name" {
  type        = string
  description = "Name of the function app"
}
variable "app_service_plan_id" {
  type        = string
  description = "(Required) The ID of the App Service Plan within which to create this Function App."
}

variable "storage_account_name" {
  type        = string
  description = "(Required) The backend storage account name which will be used by this Function App (such as the dashboard, logs)."
}

variable "storage_account_access_key" {
  type        = string
  description = "(Required) The access key which will be used to access the backend storage account for the Function App."
}

variable "app_settings" {
  type        = any
  description = "environment variables for the function"
}

# --- Keyvault
variable "keyvault_id" {
  type        = string
  description = "id string for of the keyvault used for saving connection strings"
}

variable "group_object_id" {
  type        = string
  description = "Azure AD group object id. Used for adding function app to Keyvault access policies"
}

variable "member_object_id" {
  type        = string
  description = "Function app system assigned id. Used for adding function app to Keyvault access policies"
}

# --- Monitor

variable "log_analytics_workspace_id" {
  type        = string
  description = "provides the log analytics workspace id for logging"
}

variable "application_insights_name" {
  type        = string
  description = "The name of the application insights instance"
}

variable "enable_vnet" {
  type        = bool
  description = "Dictates if vnet connection should be created in combination with function app"
}

variable "subnet_id" {
  type        = string
  description = "subnet id variable used in swift vnet connection"
  default     = null
}

variable "subscription_name" {
  type        = string
  description = "override subscription name"
  default     = null
}
