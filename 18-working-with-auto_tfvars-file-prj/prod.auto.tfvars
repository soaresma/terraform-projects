# Production-specific Terraform variable overrides.
# This file is automatically loaded by Terraform for the prod environment and
# supplements any base/default values defined elsewhere in the project.

# EC2 instance type used by the production workload.
# Larger than the default instance size to satisfy expected production capacity.
ec2_instance_type = "t3.large"

# Root/attached volume settings for the production EC2 instance.
# 'size' is in GB and 'type' defines the EBS storage class.
ec2_volume_config = {
  size = 10
  type = "gp3"
}

# Additional metadata tags applied to resources in production.
# The tag name is intentionally capitalized to match the existing conventions.
additional_tags = {
  ValuesFrom = "prod.terraform.tfvars"
}

