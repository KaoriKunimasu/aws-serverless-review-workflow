variable "name_prefix" {
  description = "Prefix used for DynamoDB resource names."
  type        = string
}

variable "billing_mode" {
  description = "Billing mode for the DynamoDB table."
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "hash_key" {
  description = "Primary partition key name."
  type        = string
  default     = "PK"
}

variable "range_key" {
  description = "Primary sort key name."
  type        = string
  default     = "SK"
}

variable "tags" {
  description = "Tags applied to DynamoDB resources."
  type        = map(string)
  default     = {}
}
