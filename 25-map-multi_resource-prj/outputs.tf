output "ec2_instance_ids" {
  value       = [for k, v in aws_instance.from_map : v.id]
  description = "IDs of EC2 instances created from map"
}


output "subnets_ids" {
  description = "IDs of the subnets created."
  value       = [for s in aws_subnet.main : s.id]
}

output "instance_tags" {
  description = "Tags of the EC2 instances created from the list configuration."
  value       = { for k, v in aws_instance.from_map : k => v.tags }
}




