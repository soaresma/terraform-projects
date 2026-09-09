# Data section:

data "aws_ami" "ubuntu" {
  most_recent = true
  # Canonical's owner ID identifies the Ubuntu image publisher.
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/*-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "nginx" {
  # We are not using the most_recent attribute because we want a specific AMI version.
  # most_recent = true

  filter {
    name   = "name"
    values = ["nginx-plus-ubuntu-24.04-v1.6-x86_64-standard-prod-b4rly35ct3dlc"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
