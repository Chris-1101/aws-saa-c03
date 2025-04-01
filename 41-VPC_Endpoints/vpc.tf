
# █░█ █ █▀█ ▀█▀ █░█ ▄▀█ █░░   █▀█ █▀█ █ █░█ ▄▀█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ▀▄▀ █ █▀▄ ░█░ █▄█ █▀█ █▄▄   █▀▀ █▀▄ █ ▀▄▀ █▀█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# VPC
module "saa_vpc" {
  source   = "../00-Shared_Resources/vpc_module"
  vpc_name = "saa-secret-vpc"
}

# Egress-Only Internet Gateway
resource "aws_egress_only_internet_gateway" "this" {
  vpc_id = module.saa_vpc.vpc.id

  tags = {
    Name = "saa-eigw"
  }
}

# EIGW Main Route Table Route
resource "aws_route" "default_ipv6" {
  route_table_id              = module.saa_vpc.vpc.main_route_table_id
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = aws_egress_only_internet_gateway.this.id
}

# --- Endpoints

# Instance Connect Endpoint
resource "aws_ec2_instance_connect_endpoint" "this" {
  subnet_id          = module.saa_vpc.subnet_app_a.id
  preserve_client_ip = false
  security_group_ids = [ aws_security_group.private.id ]

  tags = {
    Name = "saa-ec2-instance-connect"
  }
}

# S3 Gateway Endpoint
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = module.saa_vpc.vpc.id
  service_name      = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Gateway"

  tags = {
    Name = "saa-s3"
  }
}

# S3 Gateway Endpoint Route Table Association
resource "aws_vpc_endpoint_route_table_association" "web" {
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id  = module.saa_vpc.vpc.main_route_table_id
}

# --- Security Group

# Security Group
resource "aws_security_group" "private" {
  name        = "saa-private-sg"
  description = "Manages access to private resources for VPC Endpoints demo"
  vpc_id      = module.saa_vpc.vpc.id

  tags = {
    Name = "saa-private-sg"
  }
}

# --- Inbound

# Allow IPv4 EC2 Instance Connect Only
resource "aws_vpc_security_group_ingress_rule" "allow_ssm_ipv4" {
  security_group_id = aws_security_group.private.id
  description       = "Allow inbound SSH connections from EC2 Instance Connect (us-east-1)"

  cidr_ipv4   = "18.206.107.24/29"   # IPv4 EC2 Instance Connect (N.Virginia)
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
}

# Allow IPv6 EC2 Instance Connect Only
resource "aws_vpc_security_group_ingress_rule" "allow_ssm_ipv6" {
  security_group_id = aws_security_group.private.id
  description       = "Allow inbound SSH connections from EC2 Instance Connect (us-east-1)"

  cidr_ipv6   = "2600:1f18:6fe3:8c00::/56"   # IPv6 EC2 Instance Connect (N.Virginia)
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
}

# Allow Security Group Inbound
resource "aws_vpc_security_group_ingress_rule" "allow_self" {
  security_group_id = aws_security_group.private.id
  description       = "Allow all inbound connections from this SG"

  referenced_security_group_id = aws_security_group.private.id
  ip_protocol                  = "-1"
}

# HTTP Ingress Rule -- NOTE: why?
# resource "aws_vpc_security_group_ingress_rule" "allow_http" {
#   security_group_id = module.ec2_instance.ec2_sg.id
#
#   cidr_ipv4   = "0.0.0.0/0"
#   ip_protocol = "tcp"
#   from_port   = 80
#   to_port     = 80
# }

# --- Outbound

# Allow all outbound IPv4 traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_ipv4" {
  security_group_id = aws_security_group.private.id
  description       = "Allow all inbound IPv4 traffic"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

# Allow all outbound IPv6 traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_ipv6" {
  security_group_id = aws_security_group.private.id
  description       = "Allow all inbound IPv6 traffic"

  cidr_ipv6   = "::/0"
  ip_protocol = "-1"
}

