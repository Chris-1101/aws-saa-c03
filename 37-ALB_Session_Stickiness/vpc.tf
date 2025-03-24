
# █░█ █ █▀█ ▀█▀ █░█ ▄▀█ █░░   █▀█ █▀█ █ █░█ ▄▀█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ▀▄▀ █ █▀▄ ░█░ █▄█ █▀█ █▄▄   █▀▀ █▀▄ █ ▀▄▀ █▀█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# VPC
module "saa_vpc_1" {
  source   = "../00-Shared_Resources/vpc_module"
  vpc_name = "saa-vpc-1"
}

# EC2 Web Security Group
resource "aws_security_group" "ec2_web" {
  name        = "saa-web-sg"
  description = "Controls access to web instances"
  vpc_id      = module.saa_vpc_1.vpc.id
}

# HTTP Ingress to EC2 Web Instances
resource "aws_vpc_security_group_ingress_rule" "allow_http_ec2" {
  security_group_id = aws_security_group.ec2_web.id
  description       = "Allow all HTTP traffic in"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}

# HTTP Ingress from ALB Security Group (redundant given above rule)
resource "aws_vpc_security_group_ingress_rule" "allow_http_from_alb" {
  security_group_id = aws_security_group.ec2_web.id
  description       = "Allow all HTTP traffic in from the Load Balancer"

  referenced_security_group_id = aws_security_group.alb.id
  ip_protocol                  = "tcp"
  from_port                    = 80
  to_port                      = 80
}

# Allow All Outgoing Connections
resource "aws_vpc_security_group_egress_rule" "allow_all_ipv4" {
  security_group_id = aws_security_group.ec2_web.id
  description       = "Allow all outgoing IPv4 traffic"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

# Allow All Outgoing Connections
resource "aws_vpc_security_group_egress_rule" "allow_all_ipv6" {
  security_group_id = aws_security_group.ec2_web.id
  description       = "Allow all outgoing IPv6 traffic"

  cidr_ipv6   = "::/0"
  ip_protocol = "-1"
}

# Application Load Balancer Security Group
resource "aws_security_group" "alb" {
  name        = "saa-alb-sg"
  description = "Controls access to the Application Load Balancer"
  vpc_id      = module.saa_vpc_1.vpc.id
}

# HTTP Ingress to ALB
resource "aws_vpc_security_group_ingress_rule" "allow_http_alb" {
  security_group_id = aws_security_group.alb.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}

# Allow All Outgoing Connections
resource "aws_vpc_security_group_egress_rule" "allow_all_alb" {
  security_group_id = aws_security_group.alb.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

