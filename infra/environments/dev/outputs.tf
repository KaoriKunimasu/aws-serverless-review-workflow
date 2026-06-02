output "name_prefix" {
  description = "Common name prefix used in the dev environment."
  value       = local.name_prefix
}

output "aws_region" {
  description = "AWS region used by the dev environment."
  value       = var.aws_region
}

output "common_tags" {
  description = "Common tags applied to dev environment resources."
  value       = local.common_tags
}

output "cognito_user_pool_id" {
  description = "Cognito user pool ID."
  value       = module.cognito.user_pool_id
}

output "cognito_arn" {
  description = "Cognito user pool ARN."
  value       = module.cognito.user_pool_arn
}

output "cognito_client_id" {
  description = "Cognito app client ID."
  value       = module.cognito.user_pool_client_id
}

output "cognito_issuer_url" {
  description = "Cognito issuer URL."
  value       = module.cognito.issuer_url
}

output "cognito_hosted_ui_domain" {
  description = "Cognito hosted UI domain."
  value       = module.cognito.hosted_ui_domain
}

output "cognito_base_url" {
  description = "Cognito hosted UI base URL."
  value       = module.cognito.hosted_ui_base_url
}

output "cognito_authorization_endpoint" {
  description = "Cognito authorization endpoint."
  value       = module.cognito.authorization_endpoint
}

output "cognito_token_endpoint" {
  description = "Cognito token endpoint."
  value       = module.cognito.token_endpoint
}

output "workflow_table_name" {
  description = "DynamoDB workflow table name."
  value       = module.dynamodb.table_name
}

output "workflow_table_arn" {
  description = "DynamoDB workflow table ARN."
  value       = module.dynamodb.table_arn
}

output "list_requests_function_name" {
  description = "Lambda function name for listing workflow requests."
  value       = module.list_requests_function.function_name
}

output "list_requests_function_arn" {
  description = "Lambda function ARN for listing workflow requests."
  value       = module.list_requests_function.function_arn
}

output "list_requests_invoke_arn" {
  description = "Lambda invoke ARN for listing workflow requests."
  value       = module.list_requests_function.invoke_arn
}

output "create_request_function_name" {
  description = "Lambda function name for creating workflow requests."
  value       = module.create_request_function.function_name
}

output "create_request_function_arn" {
  description = "Lambda function ARN for creating workflow requests."
  value       = module.create_request_function.function_arn
}

output "create_request_invoke_arn" {
  description = "Lambda invoke ARN for creating workflow requests."
  value       = module.create_request_function.invoke_arn
}
