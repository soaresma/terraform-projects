# Resources section:
# Creates EC2 instances from a list of configuration objects. Each list item
# selects an AMI and subnet by name and receives an index-based instance name.

resource "aws_instance" "from_list" {
  # Create one instance for each entry in the configuration list.
  count = length(var.ec2_instance_config_list)
  # Resolve the configured AMI key to its AMI ID.
  ami           = local.ami_ids[var.ec2_instance_config_list[count.index].ami]
  instance_type = var.ec2_instance_config_list[count.index].instance_type
  # Resolve the configured subnet name to the corresponding subnet ID.
  subnet_id = aws_subnet.main[var.ec2_instance_config_list[count.index].subnet_name].id

  tags = {
    Project = local.project
    Name    = "${local.project}-${count.index}"
  }
}

# Creates EC2 instances from a map of configuration objects. The map key is
# preserved for stable resource addressing and is included in each name.
resource "aws_instance" "from_map" {
  # Create one instance for each map entry.
  for_each = var.ec2_instance_config_map
  # Resolve the configured AMI key to its AMI ID.
  ami           = local.ami_ids[each.value.ami]
  instance_type = each.value.instance_type
  # Resolve the configured subnet name to the corresponding subnet ID.
  subnet_id = aws_subnet.main[each.value.subnet_name].id

  tags = {
    Project = local.project
    Name    = "${local.project}-${each.key}"
  }
}


