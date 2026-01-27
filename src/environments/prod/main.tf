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
  region  = var.aws_region
  profile = "cip-001-${var.environment}"
}

# AWS provider for CloudFront/ACM certificate must be created in us-east-1.
provider "aws" {
  alias   = "us_east_1"
  region  = var.aws_region_acm
  profile = "mhooijberg-prod"
}

data "aws_caller_identity" "me" {}

# All configuration comes from input.tfvars
module "lambda_notification" {
  source = "../../modules/lambda_notification"

  project_name          = var.project_name
  domain_name           = var.domain_name
  to_address            = var.to_address
  environment           = var.environment
}

module "static_website" {
  source = "../../modules/static_website"

  project_name          = var.project_name
  domain_name           = var.domain_name
  enable_index_fallback = var.to_address
  environment           = var.environment
}