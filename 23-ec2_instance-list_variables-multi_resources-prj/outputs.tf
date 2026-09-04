output "ec2_instance_ids" {
  description = "IDs of the EC2 instances created from the list configuration."
  value       = aws_instance.from_list[*].id
}

output "subnets_ids" {
  description = "IDs of the subnets created."
  value       = aws_subnet.main[*].id
}

output "instance_tags" {
  description = "Tags of the EC2 instances created from the list configuration."
  value       = aws_instance.from_list[*].tags
}
