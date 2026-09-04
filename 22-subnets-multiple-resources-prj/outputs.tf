output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_ids" {
  value = aws_subnet.main[*].id
}

output "ec2_instance_ids" {
  value = aws_instance.from_count[*].id
}
