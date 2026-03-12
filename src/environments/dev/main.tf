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

provider "aws" {
  region  = "us-east-1"
  alias   = "second_us_east_1"
  profile = "cip-001-${var.environment}"
}

data "aws_caller_identity" "me" {}

# All configuration comes from input.tfvars
module "lambda_notification" {
  source = "../../modules/lambda_notification"

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }

  project_name     = var.project_name
  root_domain_name = var.root_domain_name
  project_domain   = var.project_domain
  to_address       = var.to_address
  environment      = var.environment
}

module "static_website" {
  source = "../../modules/static_website"

  providers = {
    aws                  = aws
    aws.us_east_1        = aws.us_east_1
    aws.second_us_east_1 = aws.second_us_east_1
  }

  project_name          = var.project_name
  root_domain_name      = var.root_domain_name
  project_domain        = var.project_domain
  enable_index_fallback = var.enable_index_fallback
  environment           = var.environment
}