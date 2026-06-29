output "resource_group_name" {
  value = module.rg.name
}

output "storage_account_name" {
  value = module.storage_account.name
}

output "keyvault_name" {
  value = module.keyvault.name
}

output "function_app_hostname" {
  value = module.function_app.resource.default_hostname
}