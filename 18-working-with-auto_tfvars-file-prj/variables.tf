# Controls which AWS region the provider (and every resource it creates)
# targets, so the whole stack can be redeployed elsewhere by changing one value.
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

# Selects the EC2 instance size used by the compute resource. Restricted via
# validation to free-tier-eligible types so this project can't accidentally
# provision (and incur cost from) a larger instance.
variable "ec2_instance_type" {
  description = "The type of EC2 instance to create"
  type        = string
  # Fails plan/apply early with a clear message instead of letting AWS
  # reject an unsupported instance type later.
  validation {
    condition     = contains(["t2.micro", "t3.micro", "t3.large", "r9g.medium"], var.ec2_instance_type)
    error_message = "The EC2 instance type must be either 't2.micro', 't3.micro', 't3.large', or 'r9g.medium'."
  }

}

# Groups the root volume's size and type into a single object so they're
# defined, passed, and validated together as one logical unit rather than
# as two independent, easy-to-mismatch variables.
variable "ec2_volume_config" {
  description = "The configuration for the EC2 instance volume"
  type = object({
    size = number # Volume size in GiB.
    type = string # EBS volume type, e.g. "gp3", "gp2", "io1".
  })

}

# Lets callers attach arbitrary extra tags (e.g. Owner, Environment, CostCenter)
# to created resources without modifying this module. Defaults to empty so
# tagging is entirely opt-in and never required to apply the configuration.
variable "additional_tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)

}
