terraform {
  backend "s3" {
    profile = "cip-001-dev"
    region  = "eu-north-1"
    bucket  = "cip001.tf-state"
    encrypt = true
    key     = "state/terraform.tfstate"
    dynamodb_table = "cip001-tf-lock"
  }
}