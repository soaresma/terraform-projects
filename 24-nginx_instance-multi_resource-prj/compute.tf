# Select the latest Ubuntu 20.04 AMI published by Canonical.
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

# Select the specific NGINX Plus AMI published by NGINX.
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

resource "aws_instance" "from_list" {
  # Create one EC2 instance for each configuration entry.
  count = length(var.ec2_instance_list_config)
  # Resolve the configured AMI name through the local AMI map.
  ami = local.ami_ids[var.ec2_instance_list_config[count.index].ami]
  # Apply the instance type from the corresponding configuration entry.
  instance_type = var.ec2_instance_list_config[count.index].instance_type
  # Distribute instances across the available subnets in round-robin order.
  subnet_id = aws_subnet.main[count.index % length(aws_subnet.main)].id

  tags = {
    # Tag each instance with the project and a unique indexed name.
    Name     = local.project
    Instance = "${local.project}-${random_id.instance_hex.hex}-ec2-${count.index}"
  }
}
