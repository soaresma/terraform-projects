# Retrieve the latest Ubuntu 22.04 LTS AMI published by Canonical.
# This allows the EC2 instance to use a supported Ubuntu base image.
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's AWS account ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Create the EC2 compute instance using the selected Ubuntu AMI.
# The instance size and root volume configuration are parameterized via variables.
resource "aws_instance" "compute" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.ec2_instance_type

  root_block_device {
    delete_on_termination = true
    volume_size           = var.ec2_volume_size
    volume_type           = var.ec2_volume_type
  }
}
