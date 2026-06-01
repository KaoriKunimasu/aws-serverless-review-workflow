locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = {
    Application = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Repository  = "aws-serverless-review-workflow"
  }
}

module "cognito" {
  source = "../../modules/cognito"

  name_prefix   = local.name_prefix
  callback_urls = var.cognito_callback_urls
  logout_urls   = var.cognito_logout_urls
  domain_prefix = var.cognito_domain_prefix
  tags          = local.common_tags
}

module "dynamodb" {
  source = "../../modules/dynamodb"

  name_prefix                    = local.name_prefix
  billing_mode                   = var.dynamodb_billing_mode
  point_in_time_recovery_enabled = var.dynamodb_point_in_time_recovery_enabled
  deletion_protection_enabled    = var.dynamodb_deletion_protection_enabled
  table_class                    = var.dynamodb_table_class
  stream_enabled                 = var.dynamodb_stream_enabled
  stream_view_type               = var.dynamodb_stream_view_type
  ttl_enabled                    = var.dynamodb_ttl_enabled
  ttl_attribute_name             = var.dynamodb_ttl_attribute_name
  tags                           = local.common_tags
}
