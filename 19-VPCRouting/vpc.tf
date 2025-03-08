
# █░█ █ █▀█ ▀█▀ █░█ ▄▀█ █░░   █▀█ █▀█ █ █░█ ▄▀█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ▀▄▀ █ █▀▄ ░█░ █▄█ █▀█ █▄▄   █▀▀ █▀▄ █ ▀▄▀ █▀█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = data.aws_vpc.saa_vpc_1.id

  tags = {
    Name = "saa-vpc-1-igw"
  }
}

# Route Table for Web Subnets
resource "aws_route_table" "this" {
  vpc_id = data.aws_vpc.saa_vpc_1.id

  tags = {
    Name = "saa-vpc-1-rt-web"
  }
}

# Default IPv4 Route
resource "aws_route" "default_ipv4" {
  route_table_id         = aws_route_table.this.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

# Default IPv6 Route
resource "aws_route" "default_ipv6" {
  route_table_id              = aws_route_table.this.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.this.id
}

# Route Table Association for Web Subnet A
resource "aws_route_table_association" "web_a" {
  subnet_id      = data.aws_subnet.saa_web_a.id
  route_table_id = aws_route_table.this.id
}

# Route Table Association for Web Subnet B
resource "aws_route_table_association" "web_b" {
  subnet_id      = data.aws_subnet.saa_web_b.id
  route_table_id = aws_route_table.this.id
}

# Route Table Association for Web Subnet C
resource "aws_route_table_association" "web_c" {
  subnet_id      = data.aws_subnet.saa_web_c.id
  route_table_id = aws_route_table.this.id
}


# ------- EC2 Security Group -------

# EC2 Security Group
resource "aws_security_group" "ec2" {
  name        = "${ local.ec2_name }-sg"
  description = "Manages access to EC2 instance ${ local.ec2_name }"
  vpc_id      = data.aws_vpc.saa_vpc_1.id

  tags = {
    Name = "${ local.ec2_name }-sg"
  }
}

# Allow inbound IPv4 SSH
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.ec2.id

  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port = 22
  to_port = 22
}

# Allow inbound IPv6 SSH
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv6" {
  security_group_id = aws_security_group.ec2.id

  cidr_ipv6 = "::/0"
  ip_protocol = "tcp"
  from_port = 22
  to_port = 22
}

# Allow all outbound IPv4 traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_ipv4" {
  security_group_id = aws_security_group.ec2.id

  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}

# Allow all outbound IPv6 traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_ipv6" {
  security_group_id = aws_security_group.ec2.id

  cidr_ipv6 = "::/0"
  ip_protocol = "-1"
}

