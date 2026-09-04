# Terraform configuration for the project.
# This block declares the minimum Terraform version and the required providers
# needed to manage AWS and random resources in this deployment.
terraform {

  # Require Terraform version 1.7.x for compatibility with the configuration.
  required_version = "~> 1.7"

  # Specify the providers and their versions used in the project.
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS provider for the target region.
# The region is supplied by the variable "aws_region", allowing
# environment-specific deployment settings.
provider "aws" {
  region = var.aws_region
}

resource "random_id" "vpc_id" {
  byte_length = 4
}

resource "random_id" "instance_hex" {
  byte_length = 4
}
