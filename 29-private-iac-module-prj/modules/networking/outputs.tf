########################################################
# Outputs for the networking module
########################################################

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.this.cidr_block
}

output "route_table" {
  description = "The ID of the public route table"
  value       = aws_route_table.public_rtb[*].id
}


output "internet_gateway" {
  description = "The ID of the internet gateway"
  value       = { for k, v in aws_internet_gateway.this : k => v.id }
}

output "public_subnets" {
  description = "The IDs of the public subnets"
  value       = local.output_public_subnets
}

output "private_subnets" {
  description = "The IDs of the private subnets"
  value       = local.output_private_subnets
}

