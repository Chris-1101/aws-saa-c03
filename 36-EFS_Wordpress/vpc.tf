
# █░█ █ █▀█ ▀█▀ █░█ ▄▀█ █░░   █▀█ █▀█ █ █░█ ▄▀█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ▀▄▀ █ █▀▄ ░█░ █▄█ █▀█ █▄▄   █▀▀ █▀▄ █ ▀▄▀ █▀█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# VPC
module "saa_vpc_1" {
  source   = "../00-Shared_Resources/vpc_module"
  vpc_name = "saa-vpc-1"
}

# HTTP Ingress Rule (Wordpress 1)
resource "aws_vpc_security_group_ingress_rule" "allow_http_1" {
  security_group_id = module.ec2_wordpress_1.ec2_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}

# HTTP Ingress Rule (Wordpress 2)
resource "aws_vpc_security_group_ingress_rule" "allow_http_2" {
  security_group_id = module.ec2_wordpress_2.ec2_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}

# Connections from Database SG
resource "aws_vpc_security_group_ingress_rule" "allow_wp_1" {
  security_group_id = module.ec2_wordpress_1.ec2_sg.id
  description       = "Allow inbound connections from Wordpress 1 SG"

  referenced_security_group_id = module.ec2_wordpress_2.ec2_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 0
  to_port                      = 65535
}

# Connections from Wordpress SG
resource "aws_vpc_security_group_ingress_rule" "allow_wp_2" {
  security_group_id = module.ec2_wordpress_2.ec2_sg.id
  description       = "Allow inbound connections from Wordpress 2 SG"

  referenced_security_group_id = module.ec2_wordpress_1.ec2_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 0
  to_port                      = 65535
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

# Connections from Wordpress 1
resource "aws_vpc_security_group_ingress_rule" "allow_wordpress_1" {
  security_group_id = aws_security_group.rds.id
  description       = "Allow inbound connections from wordpress SG"

  referenced_security_group_id = module.ec2_wordpress_1.ec2_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 3306
  to_port                      = 3306
}

# Connections from Wordpress 2
resource "aws_vpc_security_group_ingress_rule" "allow_wordpress_2" {
  security_group_id = aws_security_group.rds.id
  description       = "Allow inbound connections from wordpress SG"

  referenced_security_group_id = module.ec2_wordpress_2.ec2_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 3306
  to_port                      = 3306
}

