# Network resources for the project.
# This file defines the VPC and the subnet set used by the application.
# The subnet configuration is supplied as a map so that multiple CIDR blocks
# can be created dynamically with consistent naming and tagging.

resource "aws_subnet" "main" {
  for_each   = var.subnet_config
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value.cidr_block

  tags = {
    Project = local.project
    Name    = "${local.project}-${each.key}"
  }
}

# Creates the main VPC for the environment. The CIDR range is kept in a private
# RFC1918 space so the networking layout can be expanded safely.
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}