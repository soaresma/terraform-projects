terraform {
  required_version = "~> 1.7"

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
  region = var.aws_region
}

resource "random_id" "instance_hex" {
  byte_length = 4
}

resource "random_id" "vpc_hex" {
  byte_length = 4
}


resource "random_id" "vpc_id" {
  byte_length = 4
}
