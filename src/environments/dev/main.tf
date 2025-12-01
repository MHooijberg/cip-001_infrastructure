terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.51.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }
  }
}

# Configure the main AWS Provider
provider "aws" {
  region  = "eu-north-1"
  profile = "cip-main"
}

# AWS provider for CloudFront/ACM certificate must be created in us-east-1.
provider "aws" {
  alias   = "us_east_1"
  region  = "us-east-1"
  profile = "cip-main"
}

data "aws_caller_identity" "me" {}

# Instantiate the lambda_notification module
# All configuration comes from input.tfvars
module "lambda_notification" {
  source = "../../modules/lambda_notification"

  project_name          = var.project_name
  aws_region            = var.aws_region
  domain_name           = var.domain_name
  project_domain        = var.project_domain
  from_address          = var.from_address
  to_address            = var.to_address
  bundle_id             = var.bundle_id
  enable_index_fallback = var.enable_index_fallback
}