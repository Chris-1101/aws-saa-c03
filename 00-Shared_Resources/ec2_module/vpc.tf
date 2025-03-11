
# █░█ █ █▀█ ▀█▀ █░█ ▄▀█ █░░   █▀█ █▀█ █ █░█ ▄▀█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ▀▄▀ █ █▀▄ ░█░ █▄█ █▀█ █▄▄   █▀▀ █▀▄ █ ▀▄▀ █▀█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# EC2 Security Group
resource "aws_security_group" "ec2" {
  name        = "${ var.ec2_name }-sg"
  description = "Manages access to EC2 instance ${ var.ec2_name }"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${ var.ec2_name }-sg"
  }
}

# Allow inbound IPv4 SSH
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  count             = var.ec2_key_name == null ? 0 : 1
  security_group_id = aws_security_group.ec2.id
  description       = "Allow all inbound IPv4 TCP/22 (SSH) connections"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
}

# Allow inbound IPv6 SSH
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv6" {
  count             = var.ec2_key_name == null ? 0 : 1
  security_group_id = aws_security_group.ec2.id
  description       = "Allow all inbound IPv6 TPC/22 (SSH) connections"

  cidr_ipv6   = "::/0"
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
}

# Allow IPv4 EC2 Instance Connect Only
resource "aws_vpc_security_group_ingress_rule" "allow_ssm_ipv4" {
  count             = var.ec2_key_name == null && var.ssm_session_support ? 1 : 0
  security_group_id = aws_security_group.ec2.id
  description       = "Allow inbound SSH connections from EC2 Instance Connect (us-east-1)"

  cidr_ipv4   = "18.206.107.24/29"
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
}

# Allow IPv6 EC2 Instance Connect Only
resource "aws_vpc_security_group_ingress_rule" "allow_ssm_ipv6" {
  count             = var.ec2_key_name == null && var.ssm_session_support ? 1 : 0
  security_group_id = aws_security_group.ec2.id
  description       = "Allow inbound SSH connections from EC2 Instance Connect (us-east-1)"

  cidr_ipv6   = "2600:1f18:6fe3:8c00::/56"
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
}

# Allow Security Group Inbound
resource "aws_vpc_security_group_ingress_rule" "allow_self" {
  security_group_id = aws_security_group.ec2.id
  description       = "Allow all inbound connections from this SG"

  referenced_security_group_id = aws_security_group.ec2.id
  ip_protocol                  = "-1"
}

# Allow all outbound IPv4 traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_ipv4" {
  security_group_id = aws_security_group.ec2.id
  description       = "Allow all inbound IPv4 traffic"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

# Allow all outbound IPv6 traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_ipv6" {
  security_group_id = aws_security_group.ec2.id
  description       = "Allow all inbound IPv6 traffic"

  cidr_ipv6   = "::/0"
  ip_protocol = "-1"
}

