output "module_name" {
  description = "Module identifier."
  value       = local.module_name
}

output "planned_user_pool_name" {
  description = "Planned Cognito user pool name."
  value       = local.user_pool_name
}

output "tags" {
  description = "Tags passed to the module."
  value       = var.tags
}
