# Select the latest Ubuntu 20.04 LTS AMI published by Canonical.
data "aws_ami" "latest" {
  most_recent = true
  owners      = ["099720109477"] # Replace by Ubuntu Canonical AMI owner ID if needed

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "from_count" {
  # Create the configured number of instances and distribute them across the
  # available subnets in a round-robin pattern.
  ami           = data.aws_ami.latest.id
  instance_type = var.aws_instance_type
  count         = var.aws_instances_count
  subnet_id     = aws_subnet.main[count.index % length(aws_subnet.main)].id

  tags = {
    Name    = "${local.project}-${count.index}-instance-${random_id.instance_hex.hex}"
    Project = local.project
  }
}
