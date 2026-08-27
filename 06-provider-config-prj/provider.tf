terraform {
  required_version = "~> 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "us-west"
  region = "us-west-1"
}

resource "aws_s3_bucket" "us_east_1" {
  bucket = "provider-bucket-us-east-1-tf001"

}

resource "aws_s3_bucket" "us_west_1" {
  bucket   = "provider-bucket-us-west-1-tf002"
  provider = aws.us-west
}
