aws_region = "us-east-1"

project = "26-passing-subnets-info-multi_resources-prj"

ami = "ubuntu"

aws_subnet_count = 2

subnet_config = {
  default = {
    cidr_block = "10.0.0.0/24"
  }

  subnet_1 = {
    cidr_block = "10.0.1.0/24"
  }
}

ec2_instance_config_map = {
  ubuntu_1 = {
    instance_type = "t2.micro"
    ami           = "ubuntu"
    subnet_name   = "subnet_1"
  }
  nginx_1 = {
    instance_type = "t2.micro"
    ami           = "nginx"
    subnet_name   = "subnet_1"
  }
}

ec2_instance_config_list = [
  {
    instance_type = "t2.micro"
    ami           = "ubuntu"
    subnet_name   = "subnet_1"
  },
  {
    instance_type = "t2.micro"
    ami           = "nginx"
    subnet_name   = "subnet_1"
  }
]

