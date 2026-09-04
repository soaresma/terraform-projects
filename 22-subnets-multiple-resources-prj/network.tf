# This file defines the core networking resources for the project.
# It creates a VPC and a configurable number of subnets within that VPC.
# The subnet CIDR blocks are generated dynamically using the subnet index,
# allowing the project to scale out across multiple availability zones or
# isolated network segments.

# Creates the main VPC for the project.
# The CIDR block is a private RFC1918 range and is tagged with the project
# name so resources can be grouped and identified consistently.
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Project = local.project
    Name    = "${local.project}-vpc-${random_id.vpc_id.hex}"
  }
}

# Creates one or more subnets inside the VPC.
# The count value is controlled by the aws_subnet_count variable, so the
# number of subnets can be adjusted without changing the resource definition.
# Each subnet gets a unique CIDR block of the form 10.0.<index>.0/24,
# for example: 10.0.0.0/24, 10.0.1.0/24, 10.0.2.0/24, and so on.
resource "aws_subnet" "main" {
  count      = var.aws_subnet_count
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.${count.index}.0/24"

  tags = {
    Project = local.project
    Name    = "${local.project}-${count.index}-${random_id.vpc_id.hex}"
  }
}


