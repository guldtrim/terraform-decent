#Below variables are for connecting to Azure subscriptions
variable "azure_subscription_id" {
  type        = string
  description = "Primary subscription ID"
}

variable "azure_client_id" {
  type        = string
  description = "Primary client id"
}

variable "azure_client_secret" {
  type        = string
  description = "Primary client secret"
}


variable "azure_tenant_id" {
  type        = string
  description = "Primary tenant id"
}
