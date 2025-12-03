locals {
  # The project domain name is based on the root domain name, and the name of the project.
  project_domain        = "${var.project_name}.${var.domain_name}"
}