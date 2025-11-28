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