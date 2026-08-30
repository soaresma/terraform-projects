data "aws_vpc" "dev_vpc" {
  # Fetch details of a specific VPC based on its ID.
  tags = {
    Env = "Dev" # Replace with the actual name of your VPC.
  }
}


resource "aws_vpc" "dev_vpc" {
  # Create a new VPC with the specified CIDR block and tags.
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = data.aws_vpc.dev_vpc.id # Replace with the desired name for your VPC.
  }
}

