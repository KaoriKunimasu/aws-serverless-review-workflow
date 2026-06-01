variable "name_prefix" {
  description = "Prefix used for API resource names."
  type        = string
}

variable "stage_name" {
  description = "API Gateway stage name."
  type        = string
  default     = "$default"
}

variable "enable_cors" {
  description = "Whether CORS should be enabled for the API."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags applied to API resources."
  type        = map(string)
  default     = {}
}
