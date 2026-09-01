# Retrieves the newest official Ubuntu 20.04 LTS AMI published by Canonical.
# This keeps the EC2 instance aligned with a supported base image without
# hardcoding a region-specific AMI ID that would become stale over time.
data "aws_ami" "ubuntu" {
  most_recent = true             # Select the newest matching AMI when multiple results exist.
  owners      = ["099720109477"] # Canonical's official AWS account ID.

  # Match the Canonical Ubuntu 20.04 HVM SSD image naming pattern. The trailing
  # wildcard covers the build-date suffix appended by AWS to each published AMI.
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  # Restrict the lookup to hardware virtual machine (HVM) images, which are
  # required by the EC2 instance types used in this project.
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Creates the EC2 instance that serves as the compute resource for this project.
resource "aws_instance" "compute" {
  ami           = data.aws_ami.ubuntu.id # Dynamic AMI lookup from the data source above.
  instance_type = var.ec2_instance_type  # EC2 size selected through Terraform variables.

  # Defines the root EBS volume using a single object variable so the size and
  # volume type remain grouped and can be managed together.
  root_block_device {
    volume_size = var.ec2_volume_config.size # Root volume size in GiB.
    volume_type = var.ec2_volume_config.type # Root volume type, such as gp3.
  }

  # Merges project-specific tags with the fixed Terraform ownership tag so the
  # instance is clearly identifiable as managed by Terraform while preserving
  # any user-supplied metadata.
  tags = merge(
    {
      ManagedBy = "Terraform"
    },
    var.additional_tags
  )
}
