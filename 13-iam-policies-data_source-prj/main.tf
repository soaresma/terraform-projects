terraform {

  required_version = ">= 1.7.0"

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

provider "aws" {
  region = "us-east-1"
}

output "s3_bucket_policy_json" {
  value = data.aws_iam_policy_document.s3_bucket_policy.json
}

output "s3_bucket_name" {
  value = aws_s3_bucket.dev_bucket.bucket
}

output "aws_s3_bucket" {
  value = aws_s3_bucket.dev_bucket.id
}

output "aws_s3_bucket_name" {
  value = aws_s3_bucket.dev_bucket.bucket
}
