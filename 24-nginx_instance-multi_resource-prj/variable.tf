# variable.tf defines the input variables and local values used by this
# Terraform configuration to create and configure EC2-related resources.

# Local values
#
# Locals provide reusable values derived from input variables or data sources.

locals {
  # Project identifier reused throughout the configuration.
  project = var.project
}

locals {
  # Map of logical operating-system names to discovered AMI IDs.
  ami_ids = {
    ubuntu = data.aws_ami.ubuntu.id
    nginx  = data.aws_ami.nginx.id
  }
}

# Input variables

variable "aws_region" {
  description = "AWS region in which resources will be deployed."
  type        = string
}

variable "project" {
  description = "Name used to identify the project and its resources."
  type        = string
}

variable "aws_instance_type" {
  description = "Default AWS instance type for EC2 instances."
  type        = string
}

# List of per-instance configurations. Each object specifies the instance
# type and AMI to use for one EC2 instance.
variable "ec2_instance_list_config" {
  description = "EC2 instance configurations to apply."
  type = list(object({
    instance_type = string
    ami           = string
  }))

  default = []

  # Restrict every configured EC2 instance to the supported instance type.
  validation {
    condition = alltrue([
      for cfg in var.ec2_instance_list_config : contains(["t2.micro"], cfg.instance_type)
    ])
    error_message = "Only 't2.micro' instance type is allowed."
  }

  # Ensure each instance configuration references a supported AMI name.
  validation {
    condition = alltrue([
      for cfg in var.ec2_instance_list_config : contains(["ubuntu", "nginx"], cfg.ami)
    ])
    error_message = "At least one of the provided \"ami\" values is not supported.\nSupported \"ami\" values: \"ubuntu\", \"nginx\"."
  }

}

variable "ami" {
  description = "AMI ID to use for EC2 instances."
  type        = string
}

variable "aws_subnet_count" {
  description = "Number of subnets to create."
  type        = number
}
