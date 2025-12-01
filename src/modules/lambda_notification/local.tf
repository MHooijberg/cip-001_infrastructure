locals {
  # All configuration values are now provided as input variables
  # Use this file only for derived/computed locals if needed
  project_domain        = "${var.project_name}.${var.domain_name}" # "cip-001.mhooijberg.com"
  from_address          = "noreply@${local.project_domain}" # "noreply@cip.mhooijberg.com"
}