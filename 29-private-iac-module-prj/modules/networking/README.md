# Networking Module

This reusable Terraform module creates the basic networking foundation for an
AWS workload. It creates one VPC and any number of subnets from a declarative
configuration, while allowing each subnet to be classified as public or
private.

The module is intended to be used as a building block by a root Terraform
configuration. It does not create compute resources, security groups, NAT
gateways, or application-specific routing.

## Goals

- Create a named VPC with a caller-provided CIDR block.
- Create multiple subnets with caller-provided CIDR blocks and Availability
  Zones.
- Identify subnets as public or private through the `public` flag.
- Create public routing for public subnets when at least one public subnet is
  configured.
- Return the identifiers and Availability Zones needed by downstream modules.

## Requirements

- Terraform installed and compatible with the AWS provider version required by
  the calling project.
- An AWS provider configuration for the target region.
- Every subnet Availability Zone must exist and be available in that region.
- The caller must have permissions to create and manage VPCs, subnets, route
  tables, route table associations, and internet gateways.

## Usage

```hcl
module "networking" {
  source = "./modules/networking"

  vpc_config = {
    name       = "application-vpc"
    cidr_block = "10.0.0.0/16"
  }

  subnet_config = {
    private_app = {
      cidr_block = "10.0.1.0/24"
      az         = "us-east-1a"
      public     = false
    }

    public_web = {
      cidr_block = "10.0.2.0/24"
      az         = "us-east-1b"
      public     = true
    }
  }
}
```

The module source can also be changed to a private registry, Git repository, or
other supported Terraform module source.

## Inputs

### `vpc_config`

An object containing:

| Attribute | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `string` | yes | Name applied to the VPC and used in related resource names. |
| `cidr_block` | `string` | yes | Valid CIDR block for the VPC. |

### `subnet_config`

A map of subnet names to subnet configuration objects:

| Attribute | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `cidr_block` | `string` | yes | n/a | Valid CIDR block for the subnet. It must fit within the VPC CIDR block. |
| `az` | `string` | yes | n/a | Availability Zone in the configured AWS region. |
| `public` | `bool` | no | `false` | Marks the subnet as public and associates it with the module's public route table. |

## Networking behavior

- The VPC is always created.
- All entries in `subnet_config` create subnets in the VPC.
- If one or more subnets have `public = true`, the module creates one
  internet gateway, one public route table with a `0.0.0.0/0` route, and
  associations for those public subnets.
- If no public subnets are configured, no internet gateway or public route
  table is created.
- A subnet with `public = false` is not associated with the public route table.
  The module does not create a private route table, NAT gateway, or NAT route.
- Marking a subnet public does not automatically assign public IPv4 addresses
  to instances. Instance or launch-template configuration must handle that
  separately.

## Outputs

| Output | Description |
| --- | --- |
| `vpc_id` | ID of the created VPC. |
| `vpc_cidr` | CIDR block of the created VPC. |
| `route_table` | List containing the public route table ID, or an empty list when no public subnet exists. |
| `internet_gateway` | Map of created internet gateway IDs, or an empty map when no public subnet exists. |
| `public_subnets` | Map of public subnet names to subnet IDs and Availability Zones. |
| `private_subnets` | Map of non-public subnet names to subnet IDs and Availability Zones. |

## Validation and safety

The module validates that the VPC and subnet CIDR values are valid CIDR blocks.
It also checks each requested Availability Zone against the set of
available zones returned by AWS for the configured region. It does not validate
subnet overlap, subnet containment within the VPC, or whether the selected
CIDR ranges are suitable for a particular workload; those checks should be
performed during design and review.

Before applying changes, review the generated plan and confirm the target AWS
account, region, CIDR ranges, and route behavior. See [LICENSE.md](LICENSE.md)
for the terms covering this module.