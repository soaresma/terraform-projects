ec2_instance_type = "t2.micro"

ec2_volume_configuration = {
  size = 10
  type = "gp3"
}

aws_region = "us-east-1"

additional_tags = {
  "Application" = "APM-00123"
  "AppName"     = "Omnichannel App"
}

my_sensitive_value = "S3 sensitive value"
