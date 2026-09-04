aws_region = "us-east-1"

project = "23-ec2_instance-list_variables-multi_resources-prj"

aws_instance_type = "t2.micro"

ami = "ubuntu"

aws_subnet_count = 2

ec2_instance_list_config = [
  {
    instance_type = "t2.micro"
    ami           = "ubuntu"
  },
  {
    instance_type = "t2.micro",
    ami           = "nginx"
  },
]
