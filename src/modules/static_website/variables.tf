variable "project_name" {
  description = "Project name used for naming resources."
  type        = string
}

variable "domain_name" {
  description = "Base domain name under which the project will be hosted."
  type        = string
}

variable "enable_index_fallback" {
  description = "Enable index fallback for S3."
  type        = bool
}

variable "environment" {
  description = "The name of the environment (e.g., dev, prod)."
  type        = string
}