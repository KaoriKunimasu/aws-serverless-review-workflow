locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = {
    Application = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Repository  = "aws-serverless-review-workflow"
  }

  repo_root          = abspath("${path.root}/../../..")
  function_dist_root = "${local.repo_root}/app/functions/.dist"

  lambda_environment_base = {
    AWS_REGION          = var.aws_region
    LOG_LEVEL           = var.lambda_log_level
    WORKFLOW_TABLE_NAME = module.dynamodb.table_name
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

data "archive_file" "list_requests" {
  type        = "zip"
  source_dir  = "${local.function_dist_root}/list_requests"
  output_path = "${path.module}/list_requests.zip"
}

data "archive_file" "create_request" {
  type        = "zip"
  source_dir  = "${local.function_dist_root}/create_request"
  output_path = "${path.module}/create_request.zip"
}

module "list_requests_function" {
  source = "../../modules/lambda-function"

  function_name    = "${local.name_prefix}-list-requests"
  description      = "Lists workflow requests in the dev environment."
  runtime          = var.lambda_runtime
  handler          = "handler.lambda_handler"
  package_file     = data.archive_file.list_requests.output_path
  source_code_hash = data.archive_file.list_requests.output_base64sha256

  memory_size   = var.lambda_memory_size
  timeout       = var.lambda_timeout_seconds
  architectures = var.lambda_architectures

  environment_variables = local.lambda_environment_base

  log_retention_in_days = var.lambda_log_retention_in_days
  log_format            = "JSON"
  application_log_level = var.lambda_log_level
  system_log_level      = "INFO"

  extra_policy_statements = [
    {
      sid    = "ReadWorkflowTable"
      effect = "Allow"
      actions = [
        "dynamodb:GetItem",
        "dynamodb:Query",
        "dynamodb:Scan"
      ]
      resources = [
        module.dynamodb.table_arn,
        "${module.dynamodb.table_arn}/index/*"
      ]
    }
  ]

  tags = merge(
    local.common_tags,
    {
      Component = "list-requests"
    }
  )
}

module "create_request_function" {
  source = "../../modules/lambda-function"

  function_name    = "${local.name_prefix}-create-request"
  description      = "Creates workflow requests in the dev environment."
  runtime          = var.lambda_runtime
  handler          = "handler.lambda_handler"
  package_file     = data.archive_file.create_request.output_path
  source_code_hash = data.archive_file.create_request.output_base64sha256

  memory_size   = var.lambda_memory_size
  timeout       = var.lambda_timeout_seconds
  architectures = var.lambda_architectures

  environment_variables = local.lambda_environment_base

  log_retention_in_days = var.lambda_log_retention_in_days
  log_format            = "JSON"
  application_log_level = var.lambda_log_level
  system_log_level      = "INFO"

  extra_policy_statements = [
    {
      sid    = "WriteWorkflowTable"
      effect = "Allow"
      actions = [
        "dynamodb:PutItem"
      ]
      resources = [
        module.dynamodb.table_arn
      ]
    }
  ]

  tags = merge(
    local.common_tags,
    {
      Component = "create-request"
    }
  )
}
