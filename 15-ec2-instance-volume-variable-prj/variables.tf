# Variables for configuring the EC2 instance deployment.
# These values can be overridden at runtime using a terraform.tfvars file
# or by passing them through the CLI when applying the configuration.

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "ec2_instance_type" {
  description = "The EC2 instance type to use for the compute workload. Example values include t2.micro and t3.small."
  type        = string
  default     = "t2.micro"

  validation {
    condition     = contains(["t2.micro", "t3.micro", "t3.small"], var.ec2_instance_type)
    error_message = "Only t2.micro, t3.micro instances are supported."
  }

}

variable "ec2_volume_size" {
  description = "The size of the EC2 instance root volume in GB. This defines the storage capacity attached to the instance."
  type        = number
  default     = 10
}

variable "ec2_volume_type" {
  description = "The type of the EC2 instance root volume. Common values include gp3, gp2, io1, and standard."
  type        = string
  default     = "gp3"
}

