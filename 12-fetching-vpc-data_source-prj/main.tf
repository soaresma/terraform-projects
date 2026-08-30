terraform {

  required_version = ">= 1.7.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }

}

# provider "aws" {
#   # Configure the AWS provider with the default region.
#   region = var.aws_region
# }

# variable "aws_region" {
#   description = "The AWS region to use for the provider."
#   type        = string
#   default     = "us-east-1"
# }

data "aws_caller_identity" "current" {
  # Retrieve the AWS account ID and other details of the current caller.
}

data "aws_region" "current" {
  # Retrieve the AWS availability zones of the current region.
}

data "aws_availability_zones" "available" {
  # Retrieve the AWS availability zones of the current region.
  state = "available"
}

output "current_caller_account_id" {
  # Expose the AWS account ID of the current caller after planning or applying the configuration.
  value = data.aws_caller_identity.current
}

output "current_caller_region" {
  # Expose the AWS region of the current caller after planning or applying the configuration.
  value = data.aws_region.current.region
}

output "dev_vpc_id" {
  # Expose the VPC ID of the current caller after planning or applying the configuration.
  value = data.aws_vpc.dev_vpc.id
}

output "ec2_instance_id" {
  # Expose the EC2 instance ID of the current caller after planning or applying the configuration.
  value = data.aws_ami.ubuntu.id
}

output "azs" {
  # Expose the availability zones of the current caller after planning or applying the configuration.
  value = data.aws_availability_zones.available
}
