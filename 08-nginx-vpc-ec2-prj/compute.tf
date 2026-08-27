resource "aws_instance" "web" {

  ami                         = "ami-03893e668ac36fad3" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.public_http_traffic.id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install nginx -y
              systemctl enable nginx
              systemctl start nginx
            EOF 

  tags = merge(
    {
      Name = "resources-web"
    },
    local.common_tags
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "public_http_traffic" {
  name        = "public HTTP traffic"
  description = "Security group allowing traffic on port 443 and 80"
  vpc_id      = aws_vpc.main.id

  tags = merge(
    {
      Name = "resources-sg-traffic"
    },
    local.common_tags
  )

}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"

  tags = merge(
    {
      Name = "resources-http-ingress-rule"
    },
    local.common_tags
  )

}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"

  tags = merge(
    {
      Name = "resources-https-ingress-rule"
    },
    local.common_tags
  )
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = merge(
    {
      Name = "resources-all-egress-rule"
    },
    local.common_tags
  )


}