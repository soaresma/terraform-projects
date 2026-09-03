# Compute resources for the AWS environment.
#
# This file defines the EC2 instance used by the project and the AMI data source
# used to discover the latest Ubuntu server image for the target region.
# The configuration is intentionally split so that instance sizing, storage
# settings, and shared metadata can be managed through variables and locals.

# EC2 instance resource.
#
# Creates a web server instance based on the latest Ubuntu AMI published by
# Canonical. The instance type is controlled by the variable
# `var.ec2_instance_type`, and the root block device size/type are derived from
# `var.ec2_volume_configuration`.
#
# A `create_before_destroy` lifecycle rule ensures replacement instances are
# created before the old one is destroyed, minimizing downtime during updates.
#
# Tags are merged from the shared local tags (`local.common_tags`) and any extra
# tags supplied via `var.additional_tags`, allowing consistent environment
# metadata across resources.
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.ec2_instance_type

  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    volume_size = var.ec2_volume_configuration.size
    volume_type = var.ec2_volume_configuration.type
  }

  # Merge tags from local declared in variables.tf.
  tags = merge(local.common_tags, var.additional_tags)
}

# Ubuntu AMI data source.
#
# Looks up the most recent Ubuntu 20.04 LTS AMD64 server image owned by Canonical
# in the current AWS account/region context. The filters ensure that the image is
# an HVM-backed machine image and matches the expected Ubuntu naming pattern.
#
# This data source is referenced by the EC2 instance resource via
# `data.aws_ami.ubuntu.id`, which keeps the instance aligned with a valid AWS
# image version without hard-coding an AMI ID.
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
