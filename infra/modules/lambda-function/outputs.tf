output "module_name" {
  description = "Module identifier."
  value       = local.module_name
}

output "function_name" {
  description = "Lambda function name passed to the module."
  value       = var.function_name
}

output "runtime" {
  description = "Configured Lambda runtime."
  value       = var.runtime
}
