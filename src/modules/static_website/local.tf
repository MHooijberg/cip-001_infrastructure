locals {
  aws_region            = "eu-north-1"
  bundle_id             = "nano_2_0"
  domain_name           = "mhooijberg.com"
  enable_index_fallback = false
  project_name          = "cip-001"
  from_address          = "noreply@cip.mhooijberg.com"
  to_address            = "m.hooijberg24@gmail.com"
  project_domain        = "${local.project_name}.${local.domain_name}"
}