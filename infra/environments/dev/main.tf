locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = {
    Application = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Repository  = "aws-serverless-review-workflow"
  }
}
