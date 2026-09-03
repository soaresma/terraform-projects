# Write a terraform provider configuration for AWS.
terraform {
  required_version = "~> 1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    random = {
      version = "~> 3.0"
      source  = "hashicorp/random"
    }
  }

}

provider "aws" {
  region = var.aws_region
}

# Write a data source that identity the AWS account
data "aws_caller_identity" "current" {}

