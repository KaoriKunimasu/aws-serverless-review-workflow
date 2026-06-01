output "name_prefix" {
  description = "Common resource name prefix for the dev environment."
  value       = local.name_prefix
}

output "aws_region" {
  description = "AWS region configured for the dev environment."
  value       = var.aws_region
}

output "common_tags" {
  description = "Default tags applied through the AWS provider."
  value       = local.common_tags
}
