# Looks up the most recent official Ubuntu 20.04 (Focal) AMI published by
# Canonical, so the EC2 instance below always boots from an up-to-date image
# instead of a hardcoded AMI ID that would go stale or break across regions.
data "aws_ami" "ubuntu" {
  most_recent = true         # Pick the newest AMI when multiple matches are found.
  owners      = ["099720109477"] # Canonical's official AWS account ID.

  # Match AMI names following Canonical's Ubuntu 20.04 HVM/SSD naming pattern.
  # The trailing "*" allows for the variable build-date/serial suffix.
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  # Restrict results to hardware virtual machine (HVM) images, which is
  # required for current-generation EC2 instance types.
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

# Provisions the EC2 instance that serves as the compute resource for this project.
resource "aws_instance" "compute" {

  ami           = data.aws_ami.ubuntu.id  # AMI resolved dynamically from the data source above.
  instance_type = var.ec2_instance_type   # Instance size/type, validated in variables.tf (t2.micro or t3.micro).

  # Configures the root (boot) EBS volume using an object variable, so both
  # the size and type are defined together and can be reused/validated as a unit.
  root_block_device {
    volume_size = var.ec2_volume_config.size # Volume size in GiB (default: 10).
    volume_type = var.ec2_volume_config.type # EBS volume type, e.g. gp3 (default).
  }

  # Merges any user-supplied tags with a fixed "ManagedBy" tag, ensuring every
  # instance created by this configuration is identifiable as Terraform-managed
  # regardless of what additional tags are passed in.
  tags = merge(
    var.additional_tags, {
      ManagedBy = "Terraform"
    }
  )


}
