
# █░█ █ █▀█ ▀█▀ █░█ ▄▀█ █░░   █▀█ █▀█ █ █░█ ▄▀█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ▀▄▀ █ █▀▄ ░█░ █▄█ █▀█ █▄▄   █▀▀ █▀▄ █ ▀▄▀ █▀█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# VPC
module "saa_vpc_1" {
  source   = "../00-Shared_Resources/vpc_module"
  vpc_name = "saa-vpc-1"
}

# HTTP Ingress Rule (EFS-A)
resource "aws_vpc_security_group_ingress_rule" "allow_http_a" {
  security_group_id = module.ec2_efs_a.ec2_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}

# HTTP Ingress Rule (EFS-B)
resource "aws_vpc_security_group_ingress_rule" "allow_http_b" {
  security_group_id = module.ec2_efs_b.ec2_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}

# Connections from Database SG
resource "aws_vpc_security_group_ingress_rule" "allow_efs_b" {
  security_group_id = module.ec2_efs_a.ec2_sg.id
  description       = "Allow inbound connections from EFS-B SG"

  referenced_security_group_id = module.ec2_efs_b.ec2_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 0
  to_port                      = 65535
}

# Connections from Wordpress SG
resource "aws_vpc_security_group_ingress_rule" "allow_efs_a" {
  security_group_id = module.ec2_efs_b.ec2_sg.id
  description       = "Allow inbound connections from EFS-A SG"

  referenced_security_group_id = module.ec2_efs_a.ec2_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 0
  to_port                      = 65535
}

