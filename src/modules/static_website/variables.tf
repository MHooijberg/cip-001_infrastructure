variable "project_name" {
  description = "Project name used for naming resources."
  type        = string
}

variable "root_domain_name" {
  description = "Root domain name (e.g., mhooijberg.com). Used for Route53 zone lookup."
  type        = string
}

variable "project_domain" {
  description = "Full domain name for this project (e.g., cip-001.mhooijberg.com or dev.cip-001.mhooijberg.com)."
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