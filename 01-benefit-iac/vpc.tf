# Configure the AWS provider version and source used by this configuration.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}

# Deploy resources in the us-east-1 AWS region.
provider "aws" {
  region = "us-east-1"
}

# Create the network boundary for the demo environment.
resource "aws_vpc" "demo_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Terraform Demo VPC"
  }
}

# Public subnet for resources that require internet-routable access.
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = "10.0.0.0/24"
}

# Private subnet for resources that should not have a direct internet route.
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = "10.0.1.0/24"
}

# Attach an internet gateway to the VPC for internet connectivity.
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.demo_vpc.id
}

# Route public subnet traffic destined for the internet through the gateway.
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Associate the public subnet with its internet-enabled route table.
resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}


