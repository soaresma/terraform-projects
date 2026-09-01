# Write a terraform provider configuration for AWS.
terraform {
  required_version = "~> 1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"

      random = {
        version = "~> 3.0"
        source  = "hashicorp/random"
      }
    }
  }

}

provider "aws" {
  region = var.aws_region
}

# Write a data source that identity the AWS account
data "aws_caller_identity" "current" {}

output "aws_region" {
  value = var.aws_region
}

output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "aws_user_id" {
  value = data.aws_caller_identity.current.user_id
}

output "resource_common_tags" {
  value = local.common_tags
}

output "resource_additional_tags" {
  value = var.additional_tags
}
