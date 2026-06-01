output "module_name" {
  description = "Module identifier."
  value       = local.module_name
}

output "planned_api_name" {
  description = "Planned API name."
  value       = local.api_name
}

output "stage_name" {
  description = "Configured stage name."
  value       = var.stage_name
}
