# Expose the AWS region used to create the resources.
output "aws_region" {
  value = var.aws_region
}

# Expose the IDs of all created subnets.
output "aws_subnet_ids" {
  value = [for subnet in aws_subnet.main : subnet.id]
}

# Expose the IDs of instances created from the list input.
output "aws_instance_ids_from_list" {
  value = [for instance in aws_instance.from_list : instance.id]
}

# Expose the IDs of instances created from the map input.
output "aws_instance_ids_from_map" {
  value = [for instance in aws_instance.from_map : instance.id]
}

