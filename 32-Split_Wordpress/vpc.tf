
# █░█ █ █▀█ ▀█▀ █░█ ▄▀█ █░░   █▀█ █▀█ █ █░█ ▄▀█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ▀▄▀ █ █▀▄ ░█░ █▄█ █▀█ █▄▄   █▀▀ █▀▄ █ ▀▄▀ █▀█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# VPC
module "saa_vpc_1" {
  source   = "../00-Shared_Resources/vpc_module"
  vpc_name = "saa-vpc-1"
}

# HTTP Ingress Rule (Wordpress EC2)
resource "aws_vpc_security_group_ingress_rule" "allow_http_ec2" {
  security_group_id = module.ec2_wordpress.ec2_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}

# HTTP Ingress Rule (MariaDB EC2)
resource "aws_vpc_security_group_ingress_rule" "allow_http_db" {
  security_group_id = module.ec2_mariadb.ec2_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}

# NOTE: Due to the creation of a separate security group within
#  each EC2 module, we have to reference the source SG in each

# Connections from Database SG
resource "aws_vpc_security_group_ingress_rule" "allow_db" {
  security_group_id = module.ec2_wordpress.ec2_sg.id
  description       = "Allow inbound connections from database SG"

  referenced_security_group_id = module.ec2_mariadb.ec2_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 0
  to_port                      = 65535
}

# Connections from Wordpress SG
resource "aws_vpc_security_group_ingress_rule" "allow_wordpress" {
  security_group_id = module.ec2_mariadb.ec2_sg.id
  description       = "Allow inbound connections from wordpress SG"

  referenced_security_group_id = module.ec2_wordpress.ec2_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 0
  to_port                      = 65535
}

# Pings from Database SG
resource "aws_vpc_security_group_ingress_rule" "allow_database_pings" {
  security_group_id = module.ec2_wordpress.ec2_sg.id
  description       = "Allow echo requests from database SG"

  referenced_security_group_id = module.ec2_mariadb.ec2_sg.id
  ip_protocol                  = "icmp"
  from_port                    = 8
  to_port                      = 0
}

# Pings from Wordpress SG
resource "aws_vpc_security_group_ingress_rule" "allow_wordpress_pings" {
  security_group_id = module.ec2_mariadb.ec2_sg.id
  description       = "Allow echo requests from wordpress SG"

  referenced_security_group_id = module.ec2_wordpress.ec2_sg.id
  ip_protocol                  = "icmp"
  from_port                    = 8
  to_port                      = 0
}

