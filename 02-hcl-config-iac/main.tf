# Declare the Terraform providers required by this configuration.
terraform {
  required_providers {
    aws = {
      # Use the official AWS provider at a fixed version.
      source  = "hashicorp/aws"
      version = "5.37.0"
    }
  }
}

# Create an S3 bucket managed by Terraform.
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}

# Look up an existing S3 bucket that is managed outside this configuration.
data "aws_s3_bucket" "my_external_bucket" {
  bucket = "not-managed-by-us"
}

# Define the configurable name for the managed S3 bucket.
variable "bucket_name" {
  type        = string
  description = "My variable used to set bucket name"
  default     = "my_default_bucket_name"
}

# Expose the managed bucket's ID as a Terraform output.
output "bucket_id" {
  value = aws_s3_bucket.my_bucket.id
}

# Define reusable local values within this module.
locals {
  local_example = "This is a local variable"
}

# Load a child module from the local module-example directory.
module "my_module" {
  source = "./module-example"
}