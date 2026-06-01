variable "name_prefix" {
  description = "Prefix used for Cognito resource names."
  type        = string
}

variable "callback_urls" {
  description = "Allowed callback URLs for the application client."
  type        = list(string)
  default     = []
}

variable "logout_urls" {
  description = "Allowed logout URLs for the application client."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags applied to Cognito resources."
  type        = map(string)
  default     = {}
}
