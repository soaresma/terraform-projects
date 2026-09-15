##########################################################
# Local values for the networking module
##########################################################

# Keep public and non-public subnets in separate collections so public routing
# can be created only when it is needed.
locals {
  public_subnets  = { for key, config in var.subnet_config : key => config if config.public }
  private_subnets = { for key, config in var.subnet_config : key => config if !config.public }
}

# Expose the subnet ID and Availability Zone in a stable shape for callers.
locals {
  output_public_subnets = {
    for key in keys(local.public_subnets) : key => {
      subnet_id         = aws_subnet.this[key].id
      availability_zone = aws_subnet.this[key].availability_zone
    }
  }
}
locals {
  output_private_subnets = {
    for key in keys(local.private_subnets) : key => {
      subnet_id         = aws_subnet.this[key].id
      availability_zone = aws_subnet.this[key].availability_zone
    }
  }
}


############################################################
# Data sources for the networking module
############################################################

# The selected AWS provider region determines which Availability Zones are valid.
data "aws_availability_zones" "available" {
  state = "available"
}


############################################
# Main configuration for the networking module
############################################

# The VPC is the network boundary for every subnet created by this module.
resource "aws_vpc" "this" {
  cidr_block = var.vpc_config.cidr_block
  tags = {
    Name = var.vpc_config.name
  }
}

resource "aws_subnet" "this" {
  for_each = var.subnet_config

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az

  lifecycle {
    precondition {
      # Fail during planning when a subnet targets an unavailable AZ.
      condition     = contains(data.aws_availability_zones.available.names, each.value.az)
      error_message = <<-EOT
      "The AZ "${each.value.az}" provided for the subnet "${each.key}" is invalid."

      "The applied AWS region "${data.aws_availability_zones.available.id}" supports the following AZs: ${join(", ", data.aws_availability_zones.available.names)}"
     EOT
    }
  }

  tags = {
    Name   = each.key
    Access = each.value.public ? "public" : "private"
  }
}

# Public networking is optional: no internet gateway is created when all
# configured subnets are private.
resource "aws_internet_gateway" "this" {
  count  = length(local.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.vpc_config.name}-igw"
  }
}

resource "aws_route_table" "public_rtb" {
  count  = length(local.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this[0].id
  }

  tags = {
    Name = "${var.vpc_config.name}-public-rt"
  }
}

# Associate only subnets explicitly marked public with the public route table.
resource "aws_route_table_association" "public" {
  for_each = local.public_subnets

  subnet_id      = aws_subnet.this[each.key].id
  route_table_id = aws_route_table.public_rtb[0].id
}


