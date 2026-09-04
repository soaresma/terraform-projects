# Local session
# This local value stores the project name used to label and identify resources.
# It keeps resource names consistent and makes the configuration easier to trace.
locals {
  project = var.project
}

# Variable session
# These variables define the deployment settings for the AWS environment.
# They allow the infrastructure to be reused across regions and subnet layouts.


variable "project" {
  description = "The name of the project used for labeling and identifying resources"
  type        = string
}

# AWS region where the infrastructure should be deployed.
# This value controls where the VPC, subnets, and related resources are created.
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

# Number of subnets to create for this project.
# This value is required because the subnet count depends on the environment design.
# It is used by modules or resource blocks that iterate over subnet creation.
variable "aws_subnet_count" {
  description = "The number of subnets to create"
  type        = number
}

variable "aws_instances_count" {
  description = "The number of AWS instances to create"
  type        = number
}

variable "aws_instance_type" {
  description = "The type of AWS instances to create"
  type        = string

}
