terraform {

  # Require Terraform 1.7 or newer and the AWS provider 5.x or newer.

  required_version = ">= 1.7.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }

}

data "aws_caller_identity" "current" {
  # Retrieve the AWS account ID and other details of the current caller.
}

data "aws_region" "current" {
  # Retrieve the AWS region of the current caller.
}

output "current_caller_account_id" {
  # Expose the AWS account ID of the current caller after planning or applying the configuration.
  value = data.aws_caller_identity.current
}

output "current_caller_region" {
  # Expose the AWS region of the current caller after planning or applying the configuration.
  value = data.aws_region.current.region
}
