locals {
  computed_domain = var.environment == "prod" ? "${var.project_name}.${var.domain_name}" : "${var.environment}.${var.project_name}.${var.domain_name}"
}