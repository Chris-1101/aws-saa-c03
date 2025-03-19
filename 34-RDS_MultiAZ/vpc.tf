
# █░█ █ █▀█ ▀█▀ █░█ ▄▀█ █░░   █▀█ █▀█ █ █░█ ▄▀█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ▀▄▀ █ █▀▄ ░█░ █▄█ █▀█ █▄▄   █▀▀ █▀▄ █ ▀▄▀ █▀█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# VPC
module "saa_vpc_1" {
  source   = "../00-Shared_Resources/vpc_module"
  vpc_name = "saa-vpc-1"
}

# HTTP Ingress Rule
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = module.ec2_wordpress.ec2_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}

# RDS Security Group
resource "aws_security_group" "rds" {
  name        = "${ var.rds_name }-sg"
  description = "Manages access to RDS instance ${ var.rds_name }"
  vpc_id      = module.saa_vpc_1.vpc.id

  tags = {
    Name = "${ var.rds_name }-sg"
  }
}

# Connections from Wordpress
resource "aws_vpc_security_group_ingress_rule" "allow_wordpress" {
  security_group_id = aws_security_group.rds.id
  description       = "Allow inbound connections from wordpress SG"

  referenced_security_group_id = module.ec2_wordpress.ec2_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 3306
  to_port                      = 3306
}

