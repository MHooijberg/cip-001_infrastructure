variable "project_name" {
  description = "Project name used for naming resources"
  type        = string
}

variable "domain_name" {
  description = "Base domain name (e.g., mhooijberg.com)"
  type        = string
}

variable "enable_index_fallback" {
  description = "Enable index fallback for S3"
  type        = bool
}