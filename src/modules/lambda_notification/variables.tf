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