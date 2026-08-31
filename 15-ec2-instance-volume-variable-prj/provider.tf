# Terraform configuration for the AWS provider and required tooling.
# This file defines the minimum Terraform and AWS provider versions, configures
# the AWS provider using a variable-driven region, and exposes key configuration
# values as outputs for validation and reference after deployment.

# Terraform block:
# - required_version: pins the supported Terraform CLI version range.
# - required_providers: declares the AWS provider source and accepted version,
#   ensuring the project uses a compatible provider release.
terraform {
  required_version = "~> 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# AWS provider configuration:
# The provider is initialized in the region selected by the aws_region variable.
# This makes the configuration reusable across environments without hardcoding a
# specific AWS region in the infrastructure code.
provider "aws" {
  region = var.aws_region
}

# Output values are useful for confirming the runtime configuration after
# applying the Terraform plan. They help verify which region and EC2 settings
# are active before additional resources are created or managed.

# Output the configured AWS region so it can be displayed after deployment.
# This is useful for validating that the expected region is being used.
output "aws_region" {
  description = "AWS region selected for the deployment"
  value       = var.aws_region
}

# Output the EC2 instance type requested in the variables file.
# This helps confirm the intended instance size is being provisioned.
output "ec2_instance_type" {
  description = "EC2 instance type configured for the workload"
  value       = var.ec2_instance_type
}

# Output the desired size of the attached EBS volume.
# This can be used to validate that the configured storage capacity matches the
# deployment requirements.
output "ec2_volume_size" {
  description = "Size of the EC2 root or attached EBS volume in GiB"
  value       = var.ec2_volume_size
}

# Output the selected EBS volume type.
# This supports validation of performance and cost characteristics defined for
# the instance volume.
output "ec2_volume_type" {
  description = "EBS volume type configured for the EC2 instance"
  value       = var.ec2_volume_type
}