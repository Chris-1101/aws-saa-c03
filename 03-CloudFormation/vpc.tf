
# █░█ █ █▀█ ▀█▀ █░█ ▄▀█ █░░   █▀█ █▀█ █ █░█ ▄▀█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ▀▄▀ █ █▀▄ ░█░ █▄█ █▀█ █▄▄   █▀▀ █▀▄ █ ▀▄▀ █▀█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# Security Group
resource "aws_security_group" "saa_first_instance" {
  name        = "${ local.name }-sg"
  description = "Manages access to EC2 instance saa-first-instance"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "${ local.name }-sg"
  }
}

# Allow inbound IPv4 SSH
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.saa_first_instance.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
}

# Allow inbound IPv4 HTTP
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.saa_first_instance.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}

# Allow all outbound IPv4 traffic
resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.saa_first_instance.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

