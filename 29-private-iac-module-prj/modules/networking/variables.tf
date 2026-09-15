#######################################
# Variables for the networking module
#######################################

variable "vpc_config" {
  description = "Configuration for the VPC"
  type = object({
    cidr_block = string
    name       = string

  })

  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "The cidr_block config option must contain a valid CIDR block."
  }
}

variable "subnet_config" {
  description = "Configuration for the subnets"
  type = map(object({
    cidr_block = string
    public     = optional(bool, false)
    az         = string
  }))

  validation {
    condition     = alltrue([for subnet in values(var.subnet_config) : can(cidrnetmask(subnet.cidr_block))])
    error_message = "The cidr_block config option must contain a valid CIDR block."
  }
}


