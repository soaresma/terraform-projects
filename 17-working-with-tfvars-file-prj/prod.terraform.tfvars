# Terraform variable values for this project.
# This file is automatically loaded by Terraform because it is named terraform.tfvars.
# It stores environment-specific values that are used to configure the AWS resources
# and metadata for this deployment. These values can be overridden by other tfvars
# files or by command-line variables when needed.

# AWS region where the infrastructure will be provisioned.
aws_region = "us-west-1"

# EC2 instance size to use for the workload in this environment.
# Example: t2.micro is a low-cost instance suitable for learning and small workloads.
ec2_instance_type = "r9g.medium"

# Configuration for the EC2 volume attached to the instance.
ec2_volume_config = {
  size = 100 # Volume size in GiB.
  type = "gp2" # General purpose SSD volume type with good performance/cost balance.
}

# Additional tags applied to resources for identification and management.
# The tag name is intentionally capitalized here to demonstrate a custom tag value.
additional_tags = {
  ValuesFrom = "prod.terraform.tfvars" # Indicates these values were sourced from this file.
}

