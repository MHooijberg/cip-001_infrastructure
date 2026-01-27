variable "project_name" {
  description = "Project name used for naming resources."
  type        = string
}

variable "domain_name" {
  description = "Base domain name under which the project will be hosted."
  type        = string
}

variable "to_address" {
  description = "Email address for receiving notifications."
  type        = string
}

variable "environment" {
  description = "The name of the environment (e.g., dev, prod)."
  type        = string
}