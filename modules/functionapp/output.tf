#below output are used to export attributes so they are available outside the module
output "function_app_id" {
  value = azurerm_function_app.functionapp.id
}

output "function_app_name" {
  value = azurerm_function_app.functionapp.name
}

output "function_app_principal_id" {
  value = azurerm_function_app.functionapp.identity.0.principal_id
}
