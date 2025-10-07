terraform {
  backend "s3" {
    bucket  = "cip001.tf-state"
    key     = "state/terraform.tfstate"
    region  = "eu-north-1"
    encrypt = true
    profile = "cip-prod"
  }
}