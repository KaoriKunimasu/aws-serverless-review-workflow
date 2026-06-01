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
