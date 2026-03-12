locals {
  is_prod         = var.environment == "prod"
  computed_domain = local.is_prod ? "${var.project_domain}" : "${var.environment}.${var.project_domain}"
}