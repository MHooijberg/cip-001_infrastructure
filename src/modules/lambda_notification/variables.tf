variable "project_name" {
  description = "Project name used for naming resources"
  type        = string
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-north-1"
}

variable "domain_name" {
  description = "Base domain name (e.g., mhooijberg.com)"
  type        = string
}

variable "project_domain" {
  description = "Full project domain (e.g., cip-001.mhooijberg.com)"
  type        = string
}

variable "from_address" {
  description = "Email address for sending notifications"
  type        = string
}

variable "to_address" {
  description = "Email address for receiving notifications"
  type        = string
}

variable "bundle_id" {
  description = "Lightsail bundle identifier"
  type        = string
  default     = "nano_2_0"
}

variable "enable_index_fallback" {
  description = "Enable index fallback for S3"
  type        = bool
  default     = false
}
