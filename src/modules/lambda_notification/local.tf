locals {
  is_prod         = var.environment == "prod"
  computed_domain = local.is_prod ? "${var.project_domain}" : "${var.environment}.${var.project_domain}"

  # The email address from which the notifications are send will be a noreply domain, based on the project domain.
  from_address = "noreply@${var.project_domain}"
}