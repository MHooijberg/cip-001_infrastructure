variable "project_name" {
  description = "Project name used for naming resources"
  type        = string
}

variable "domain_name" {
  description = "Base domain name (e.g., mhooijberg.com)"
  type        = string
}

variable "to_address" {
  description = "Email address for receiving notifications"
  type        = string
}

variable "enable_index_fallback" {
  description = "Enable index fallback for S3"
  type        = bool
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-north-1"
}

variable "aws_region_acm" {
  description = "AWS region for ACM certificates (CloudFront requires us-east-1)"
  type        = string
  default     = "us-east-1"
}