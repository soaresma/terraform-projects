locals {

  common_tags = {
    ManagedBy = "Terraform"
    Project   = "08-nginx-vpc-ec2-prj"
  }

}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = merge(
    {
      Name = "resources-vpc"
    },
    local.common_tags
  )

}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"

  tags = merge(
    {
      Name = "resources-public"
    },
    local.common_tags
  )

}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    {
      Name = "resources-igw"
    },
    local.common_tags
  )

}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    {
      Name = "resources-public-rtb"
    },
    local.common_tags
  )

}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rtb.id


}





