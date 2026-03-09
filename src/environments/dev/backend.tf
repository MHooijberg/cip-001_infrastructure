
terraform {
  backend "s3" {
    profile      = "cip-001-dev"
    region       = "eu-north-1"
    bucket       = "cip001dev.tf-state"
    encrypt      = true
    key          = "state/terraform.tfstate"
    use_lockfile = true
  }
}