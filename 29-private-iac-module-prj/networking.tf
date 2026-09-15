############################################################
# Principal networking resources for the private IAC module
############################################################

module "vpc" {
  source = "./modules/networking"

  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "29-main-vpc"
  }

  subnet_config = {
    "subnet1" = {
      cidr_block = "10.0.1.0/24"
      az         = "us-east-1a"
    }
    "subnet2" = {
      cidr_block = "10.0.2.0/24"
      public     = true
      az         = "us-east-1b"
    }
  }


}

############################################################
# Outputs for the networking module
############################################################
output "vpc_name" {
  description = "The name of the VPC"
  value       = module.vpc
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}


output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr
}

output "route_table" {
  description = "The ID of the public route table"
  value       = module.vpc.route_table
}

output "internet_gateway" {
  description = "The ID of the internet gateway"
  value       = module.vpc.internet_gateway
}

output "public_subnets" {
  description = "The IDs of the public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "The IDs of the private subnets"
  value       = module.vpc.private_subnets
}

