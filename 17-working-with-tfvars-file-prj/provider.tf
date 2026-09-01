# Terraform configuration for AWS provider and outputs
# Defines required version constraints and provider setup

terraform {
  required_version = "~> 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS provider with the specified region
provider "aws" {
  region = var.aws_region
}

# Output the created EC2 instance metadata for downstream automation and verification.
# These values make it easier to inspect the provisioned resource without reading state.
output "instance_id" {
  description = "The unique ID of the EC2 instance created by this configuration."
  value       = aws_instance.compute.id
}

output "ec2_instance_type" {
  description = "The EC2 instance type selected for the compute resource."
  value       = aws_instance.compute.instance_type
}

output "ec2_volume_size" {
  description = "The size in GiB of the root EBS volume attached to the instance."
  value       = aws_instance.compute.root_block_device[0].volume_size
}

output "ec2_volume_type" {
  description = "The storage class of the EC2 root volume, such as gp3 or gp2."
  value       = aws_instance.compute.root_block_device[0].volume_type
}

output "additional_tags" {
  description = "All user-defined tags applied to the EC2 instance for resource organization."
  value       = aws_instance.compute.tags
}
