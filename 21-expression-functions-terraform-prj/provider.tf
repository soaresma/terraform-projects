# Terraform CLI and provider version constraints for this project.
terraform {
  # Use a compatible Terraform 1.7 release.
  required_version = "~> 1.7"

  required_providers {
    # Provider for managing AWS resources.
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    # Provider for generating random values and identifiers.
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}
