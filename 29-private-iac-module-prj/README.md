# Private Terraform Module Project

This project demonstrates how to build and consume a reusable Terraform module for AWS networking. It defines a VPC and subnet structure in a modular way, separating the network configuration from the root Terraform project so it can be reused and scaled more easily.

The infrastructure creates a VPC in the us-east-1 region, configures multiple subnets across different Availability Zones, and marks one subnet as public and another as private. The module also exposes outputs for the VPC ID, CIDR, public route table, internet gateway, and subnet details, making it easy to integrate with downstream resources.

This example is useful for learning how Terraform modules work in real-world AWS environments, especially for organizing networking components into reusable building blocks. It highlights key concepts such as module reuse, input configuration, outputs, and public/private subnet design.
