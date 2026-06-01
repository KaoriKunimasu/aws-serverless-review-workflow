variable "project_name" {
  description = "Application name used as the base for resource names and tags."
  type        = string
  default     = "review-workflow"

  validation {
    condition     = length(trim(var.project_name, " ")) > 0
    error_message = "project_name must not be empty."
  }
}

variable "environment" {
  description = "Environment name for this root module."
  type        = string
  default     = "dev"

  validation {
    condition     = var.environment == "dev"
    error_message = "environment must be set to dev in this root module."
  }
}

variable "aws_region" {
  description = "AWS region for the dev environment."
  type        = string
  default     = "ap-southeast-2"
}

variable "allowed_account_ids" {
  description = "Optional list of AWS account IDs allowed for this root module."
  type        = list(string)
  default     = ["515241425905"]
}

variable "cognito_callback_urls" {
  description = "Allowed callback URLs for the Cognito app client in the dev environment."
  type        = list(string)
  default = [
    "http://localhost:5173/login",
  ]

  validation {
    condition     = length(var.cognito_callback_urls) > 0
    error_message = "cognito_callback_urls must contain at least one URL."
  }
}

variable "cognito_logout_urls" {
  description = "Allowed logout URLs for the Cognito app client in the dev environment."
  type        = list(string)
  default = [
    "http://localhost:5173/login",
  ]

  validation {
    condition     = length(var.cognito_logout_urls) > 0
    error_message = "cognito_logout_urls must contain at least one URL."
  }
}

variable "cognito_domain_prefix" {
  description = "Hosted UI domain prefix for the Cognito user pool in the dev environment."
  type        = string
  default     = "review-workflow-dev-515241425905"

  validation {
    condition     = var.cognito_domain_prefix == "" || can(regex("^[a-z0-9-]+$", var.cognito_domain_prefix))
    error_message = "cognito_domain_prefix must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "dynamodb_billing_mode" {
  description = "Billing mode for the DynamoDB table in the dev environment."
  type        = string
  default     = "PAY_PER_REQUEST"

  validation {
    condition     = var.dynamodb_billing_mode == "PAY_PER_REQUEST"
    error_message = "dynamodb_billing_mode must be PAY_PER_REQUEST in this environment."
  }
}

variable "dynamodb_point_in_time_recovery_enabled" {
  description = "Whether point-in-time recovery is enabled for the DynamoDB table."
  type        = bool
  default     = true
}

variable "dynamodb_deletion_protection_enabled" {
  description = "Whether deletion protection is enabled for the DynamoDB table."
  type        = bool
  default     = false
}

variable "dynamodb_table_class" {
  description = "Table class for the DynamoDB table."
  type        = string
  default     = "STANDARD"

  validation {
    condition     = contains(["STANDARD", "STANDARD_INFREQUENT_ACCESS"], var.dynamodb_table_class)
    error_message = "dynamodb_table_class must be STANDARD or STANDARD_INFREQUENT_ACCESS."
  }
}

variable "dynamodb_stream_enabled" {
  description = "Whether DynamoDB Streams are enabled for the table."
  type        = bool
  default     = false
}

variable "dynamodb_stream_view_type" {
  description = "Stream view type for the DynamoDB table when streams are enabled."
  type        = string
  default     = "NEW_AND_OLD_IMAGES"

  validation {
    condition = contains([
      "KEYS_ONLY",
      "NEW_IMAGE",
      "OLD_IMAGE",
      "NEW_AND_OLD_IMAGES",
    ], var.dynamodb_stream_view_type)
    error_message = "dynamodb_stream_view_type must be a valid DynamoDB stream view type."
  }
}

variable "dynamodb_ttl_enabled" {
  description = "Whether TTL is enabled for the DynamoDB table."
  type        = bool
  default     = false
}

variable "dynamodb_ttl_attribute_name" {
  description = "TTL attribute name for the DynamoDB table."
  type        = string
  default     = "ExpiresAt"
}
