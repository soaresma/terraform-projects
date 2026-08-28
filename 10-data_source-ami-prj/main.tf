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

provider "aws" {
  # Configure AWS using the region supplied through the aws_region variable.
  region = var.aws_region
}

variable "aws_region" {
  # AWS region in which the AMI lookup and EC2 instance are managed.
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}