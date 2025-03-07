
# █░█ █ █▀█ ▀█▀ █░█ ▄▀█ █░░   █▀█ █▀█ █ █░█ ▄▀█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ▀▄▀ █ █▀▄ ░█░ █▄█ █▀█ █▄▄   █▀▀ █▀▄ █ ▀▄▀ █▀█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# VPC
resource "aws_vpc" "this" {
  cidr_block = "10.16.0.0/16"   # IPv4

  # IPv6 CIDR Block
  assign_generated_ipv6_cidr_block     = true
  ipv6_cidr_block_network_border_group = "us-east-1"

  # Instance Tenancy
  instance_tenancy = "default"

  # DNS
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "saa-vpc-1"
  }
}

