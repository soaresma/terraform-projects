# Configure Terraform and pin the required provider versions.
terraform {
  # Require a compatible Terraform CLI version.
  required_version = "~> 1.7"
  required_providers {
    # AWS provider used to create the S3 bucket.
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    # Random provider used to generate a unique bucket-name suffix.
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  # Store this project's Terraform state remotely in S3.
  backend "s3" {
    bucket = "backend-tfstate-recovery-backup"
    key    = "04-s3-backend-state-repo/terraform.tfstate"
    region = "us-east-1"
  }
}

# Deploy AWS resources in the us-east-1 region.
provider "aws" {
  region = "us-east-1"
}

# Generate a stable six-byte suffix for the globally unique bucket name.
resource "random_id" "bucket_suffix" {
  byte_length = 6
}

# Create the example S3 bucket using the generated unique suffix.
resource "aws_s3_bucket" "example_bucket" {
  bucket = "example-bucket-${random_id.bucket_suffix.hex}"
}

# Return the bucket name as a Terraform output.
output "bucket_name" {
  value = aws_s3_bucket.example_bucket.bucket
}

