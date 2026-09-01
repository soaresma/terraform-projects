# Write a aws region variable assigning it us-east-1 default value
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

# Write a ec2 intance type variable with the following validation:
# Only accept t2.micro or t3.micro
variable "ec2_instance_type" {
  description = "The EC2 instance type to use"
  type        = string

  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.ec2_instance_type)
    error_message = "Only t2.micro or t3.micro instance types are allowed."
  }
}

# Write a ec2 volume size defining size as a number and type as string declaring within a object type.
variable "ec2_volume_configuration" {
  description = "The EC2 volume configuration"
  type = object({
    size = number
    type = string
  })
}

variable "additional_tags" {
  description = "Additional tags to merge with common tags"
  type        = map(string)
}
