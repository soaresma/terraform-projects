###############################################
# Outputs for the 28-public-iac-modules-prj module
###############################################

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "ec2_instance_id" {
  value = module.ec2.id
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}