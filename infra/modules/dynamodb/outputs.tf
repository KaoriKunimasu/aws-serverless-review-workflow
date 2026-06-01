output "module_name" {
  description = "Module identifier."
  value       = local.module_name
}

output "planned_table_name" {
  description = "Planned DynamoDB table name."
  value       = local.table_name
}

output "billing_mode" {
  description = "Configured billing mode."
  value       = var.billing_mode
}
