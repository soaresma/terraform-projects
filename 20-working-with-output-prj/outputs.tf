# Exposes the AWS region used by the project.
output "aws_region" {
  value = var.aws_region
}

# Exposes the AWS account ID for the current credentials.
output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

# Exposes the unique user or role ID for the current credentials.
output "aws_user_id" {
  value = data.aws_caller_identity.current.user_id
}

# Exposes the additional tags configured for project resources.
output "resource_additional_tags" {
  value = var.additional_tags
}

# Exposes the name of the project S3 bucket.
output "s3_bucket_name" {
  value       = aws_s3_bucket.project_bucket.bucket
  description = "The name of S3 bucket"
  sensitive   = true
}

# Exposes the configured sensitive tag value while redacting it from normal CLI output.
output "sensitive_tag" {
  value       = var.my_sensitive_value
  description = "A sensitive tag value"
  sensitive   = true
}

output "aws_ec2_instance_ids" {
  value       = aws_instance.web.*.id
  description = "The IDs of the EC2 instances"
  sensitive   = true
}
