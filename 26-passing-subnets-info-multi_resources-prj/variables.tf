# Input variables and locals for the multi-subnet/multi-instance EC2 project.
# Defines project/region/AMI settings plus map- and list-based subnet and
# EC2 instance configurations used by network.tf and compute.tf.

# Local section:

locals {
  project = var.project
}

locals {
  # Map of logical operating-system names to discovered AMI IDs.
  ami_ids = {
    ubuntu = data.aws_ami.ubuntu.id
    nginx  = data.aws_ami.nginx.id
  }
}

# Variable section:

variable "project" {
  description = "Name of the project."
  type        = string
}

variable "aws_region" {
  description = "Identifier for the AWS region in which resources will be deployed."
  type        = string
}

variable "ami" {
  description = "AMI ID to use for EC2 instances."
  type        = string
}

variable "aws_subnet_count" {
  description = "Number of subnets to create."
  type        = number
}

variable "subnet_config" {
  description = "Mapping of subnet configurations."
  type = map(object({
    cidr_block = string
  }))

  validation {
    condition     = alltrue([for config in values(var.subnet_config) : can(cidrnetmask(config.cidr_block))])
    error_message = "At least one of the provided CIDR block is not valid."
  }
}

variable "ec2_instance_config_map" {
  description = "Map of EC2 instance configurations keyed by instance name."
  type = map(object({
    instance_type = string
    ami           = string
    subnet_name   = optional(string, "default")
  }))
  default = {}

  validation {
    condition = alltrue([
      for cfg in values(var.ec2_instance_config_map) : contains(["t2.micro"], cfg.instance_type)
    ])
    error_message = "Only 't2.micro' instance type is allowed."
  }

  validation {
    condition = alltrue([
      for cfg in values(var.ec2_instance_config_map) : contains(["ubuntu", "nginx"], cfg.ami)
    ])
    error_message = "At least one of the provided \"ami\" values is not supported.\nSupported \"ami\" values: \"ubuntu\", \"nginx\"."
  }
}

variable "ec2_instance_config_list" {
  description = "List of EC2 instance configurations."
  type = list(object({
    instance_type = string
    ami           = string
    subnet_name   = optional(string, "default")
  }))
  default = []

  validation {
    condition = alltrue([
      for cfg in var.ec2_instance_config_list : contains(["t2.micro"], cfg.instance_type)
    ])
    error_message = "Only 't2.micro' instance type is allowed."
  }

  validation {
    condition = alltrue([
      for cfg in var.ec2_instance_config_list : contains(["ubuntu", "nginx"], cfg.ami)
    ])
    error_message = "At least one of the provided \"ami\" values is not supported.\nSupported \"ami\" values: \"ubuntu\", \"nginx\"."
  }
}