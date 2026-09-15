# Shared project label used for the instance tags and output context.
locals {
  project_name = "13-local-modules"
}

# Select the latest Canonical Ubuntu 22.04 AMD64 AMI that uses HVM
# virtualization in the configured AWS region.
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Owner is Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Launch the workload in the private subnet created by the VPC module.
resource "aws_instance" "this" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = module.vpc.private_subnets["subnet1"].subnet_id
  tags = {
    Name    = local.project_name
    Project = local.project_name
  }
}

# Export the instance identifier for use by other Terraform configurations.
output "aws_instance_id" {
  value = aws_instance.this.id
}

# Export both address types so callers can use the address appropriate to
# their network path.
output "aws_instance_public_ip" {
  value = aws_instance.this.public_ip
}
output "aws_instance_private_ip" {
  value = aws_instance.this.private_ip
}
