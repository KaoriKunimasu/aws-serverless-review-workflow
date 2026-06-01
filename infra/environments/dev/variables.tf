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
  default     = "ap-northeast-1"
}

variable "allowed_account_ids" {
  description = "Optional list of AWS account IDs allowed for this root module. Leave empty to disable the guard during initial setup."
  type        = list(string)
  default     = []
}
