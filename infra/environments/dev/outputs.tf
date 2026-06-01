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

output "cognito_user_pool_id" {
  description = "Cognito user pool ID for the dev environment."
  value       = module.cognito.user_pool_id
}

output "cognito_user_pool_arn" {
  description = "Cognito user pool ARN for the dev environment."
  value       = module.cognito.user_pool_arn
}

output "cognito_user_pool_client_id" {
  description = "Cognito app client ID for the dev environment."
  value       = module.cognito.user_pool_client_id
}

output "cognito_issuer_url" {
  description = "JWT issuer URL for the Cognito user pool."
  value       = module.cognito.issuer_url
}

output "cognito_hosted_ui_domain" {
  description = "Hosted UI domain prefix for the Cognito user pool."
  value       = module.cognito.hosted_ui_domain
}

output "cognito_hosted_ui_base_url" {
  description = "Hosted UI base URL for the Cognito user pool."
  value       = module.cognito.hosted_ui_base_url
}

output "cognito_authorization_endpoint" {
  description = "Hosted UI authorization endpoint for the Cognito user pool."
  value       = module.cognito.authorization_endpoint
}

output "cognito_token_endpoint" {
  description = "Hosted UI token endpoint for the Cognito user pool."
  value       = module.cognito.token_endpoint
}

output "dynamodb_table_name" {
  description = "DynamoDB table name for the dev environment."
  value       = module.dynamodb.table_name
}

output "dynamodb_table_arn" {
  description = "DynamoDB table ARN for the dev environment."
  value       = module.dynamodb.table_arn
}

output "dynamodb_billing_mode" {
  description = "Billing mode for the DynamoDB table."
  value       = module.dynamodb.billing_mode
}

output "dynamodb_hash_key" {
  description = "Primary partition key name for the DynamoDB table."
  value       = module.dynamodb.hash_key
}

output "dynamodb_range_key" {
  description = "Primary sort key name for the DynamoDB table."
  value       = module.dynamodb.range_key
}

output "dynamodb_gsi1_name" {
  description = "First global secondary index name for the DynamoDB table."
  value       = module.dynamodb.gsi1_name
}

output "dynamodb_gsi1_hash_key" {
  description = "First global secondary index partition key name."
  value       = module.dynamodb.gsi1_hash_key
}

output "dynamodb_gsi1_range_key" {
  description = "First global secondary index sort key name."
  value       = module.dynamodb.gsi1_range_key
}

output "dynamodb_stream_enabled" {
  description = "Whether DynamoDB Streams are enabled for the table."
  value       = module.dynamodb.stream_enabled
}

output "dynamodb_stream_arn" {
  description = "DynamoDB stream ARN, if streams are enabled."
  value       = module.dynamodb.stream_arn
}
