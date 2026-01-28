locals {
  # The project domain name is based on the root domain name, and the name of the project.
  project_domain        =  var.environment == "prod" ? "${var.project_name}.${var.domain_name}" : "${var.environment}.${var.project_name}.${var.domain_name}"
  # The email address from which the notifications are send will be a noreply domain, based on the project domain.
  from_address          = "noreply@${local.project_domain}"
}