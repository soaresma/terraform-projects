################################################
# Locals declaration for the networking module
################################################

locals {
  vpd_cidr       = "10.0.0.0/16"
  private_subnet = ["10.0.0.0/24"]
  public_subnet  = ["10.0.128.0/24"]
}

#################################################
# Data Sources for Networking
#################################################

data "aws_availability_zones" "azs" {
  state = "available"
}

##################################################
# VPC Module
##################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.3"

  cidr            = local.vpd_cidr
  name            = local.project_name
  azs             = data.aws_availability_zones.azs.names
  private_subnets = local.private_subnet
  public_subnets  = local.public_subnet
}
