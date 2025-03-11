
# █░█ █ █▀█ ▀█▀ █░█ ▄▀█ █░░   █▀█ █▀█ █ █░█ ▄▀█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ▀▄▀ █ █▀▄ ░█░ █▄█ █▀█ █▄▄   █▀▀ █▀▄ █ ▀▄▀ █▀█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# VPC
module "saa_vpc_1" {
  source   = "../00-Shared_Resources/vpc_module"
  vpc_name = "saa-vpc-1"
}

# HTTP Ingress Rule A1
resource "aws_vpc_security_group_ingress_rule" "allow_http_a1" {
  security_group_id = module.ec2_instance_a1.ec2_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}

# HTTP Ingress Rule A2
resource "aws_vpc_security_group_ingress_rule" "allow_http_a2" {
  security_group_id = module.ec2_instance_a2.ec2_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}

# HTTP Ingress Rule B1
resource "aws_vpc_security_group_ingress_rule" "allow_http_b1" {
  security_group_id = module.ec2_instance_b1.ec2_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}

# HTTP Ingress Rule M5
# resource "aws_vpc_security_group_ingress_rule" "allow_http_m5" {
#   security_group_id = module.ec2_instance_m5.ec2_sg.id
#
#   cidr_ipv4   = "0.0.0.0/0"
#   ip_protocol = "tcp"
#   from_port   = 80
#   to_port     = 80
# }

