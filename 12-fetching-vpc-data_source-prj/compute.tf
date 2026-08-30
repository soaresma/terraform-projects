data "aws_ami" "ubuntu" {
  # Find the newest Canonical Ubuntu 22.04 server AMI matching these filters.
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


resource "aws_instance" "web" {
  # Launch a small EC2 instance from the dynamically selected Ubuntu AMI.
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  region        = data.aws_region.current.region


  root_block_device {
    # Use a 10 GiB gp3 root volume and remove it when the instance is terminated.
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }
}
