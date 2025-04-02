
# █░█ █ █▀█ ▀█▀ █░█ ▄▀█ █░░   █▀█ █▀█ █ █░█ ▄▀█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ▀▄▀ █ █▀▄ ░█░ █▄█ █▀█ █▄▄   █▀▀ █▀▄ █ ▀▄▀ █▀█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# VPC A
resource "aws_vpc" "a" {
  cidr_block = "10.16.0.0/16"

  # Instance Tenancy
  instance_tenancy = "default"

  # DNS
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "saa-vpc-a"
  }
}

# VPC B
resource "aws_vpc" "b" {
  cidr_block = "10.17.0.0/16"

  # Instance Tenancy
  instance_tenancy = "default"

  # DNS
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "saa-vpc-b"
  }
}

# VPC C
resource "aws_vpc" "c" {
  cidr_block = "10.18.0.0/16"

  # Instance Tenancy
  instance_tenancy = "default"

  # DNS
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "saa-vpc-c"
  }
}

# --- Subnets

# VPC A Subnet
resource "aws_subnet" "a" {
  vpc_id = aws_vpc.a.id

  availability_zone = "us-east-1a"
  cidr_block        = "10.16.0.0/20"

  tags = {
    Name = "saa-subnet-a"
  }
}

# VPC B Subnet
resource "aws_subnet" "b" {
  vpc_id = aws_vpc.b.id

  availability_zone = "us-east-1a"
  cidr_block        = "10.17.0.0/20"

  tags = {
    Name = "saa-subnet-b"
  }
}

# VPC C Subnet
resource "aws_subnet" "c" {
  vpc_id = aws_vpc.c.id

  availability_zone = "us-east-1a"
  cidr_block        = "10.18.0.0/20"

  tags = {
    Name = "saa-subnet-c"
  }
}

# --- Security Groups

# VPC A Security Group
resource "aws_security_group" "vpc_a" {
  name        = "saa-vpc-a-sg"
  description = "Manages access to private resources for VPC A"
  vpc_id      = aws_vpc.a.id

  tags = {
    Name = "saa-vpc-a-sg"
  }
}

# Allow SG's Inbound Traffic
resource "aws_vpc_security_group_ingress_rule" "vpc_a_allow_self" {
  security_group_id = aws_security_group.vpc_a.id
  description       = "Allow all inbound connections from this SG"

  referenced_security_group_id = aws_security_group.vpc_a.id
  ip_protocol                  = "-1"
}

# Allow All Outbound Traffic
resource "aws_vpc_security_group_egress_rule" "vpc_a_allow_all" {
  security_group_id = aws_security_group.vpc_a.id
  description       = "Allow all outbound traffic"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

# VPC B Security Group
resource "aws_security_group" "vpc_b" {
  name        = "saa-vpc-b-sg"
  description = "Manages access to private resources for VPC B"
  vpc_id      = aws_vpc.b.id

  tags = {
    Name = "saa-vpc-b-sg"
  }
}

# Allow SG's Inbound Traffic
resource "aws_vpc_security_group_ingress_rule" "vpc_b_allow_self" {
  security_group_id = aws_security_group.vpc_b.id
  description       = "Allow all inbound connections from this SG"

  referenced_security_group_id = aws_security_group.vpc_b.id
  ip_protocol                  = "-1"
}

# Allow Echo Requests From VPC A
resource "aws_vpc_security_group_ingress_rule" "vpc_b_allow_vpc_a_icmp" {
  security_group_id = aws_security_group.vpc_b.id
  description       = "Allow inbound echo requests from VPC A SG"

  referenced_security_group_id = aws_security_group.vpc_a.id
  ip_protocol                  = "icmp"
  from_port                    = 8
  to_port                      = 0
}

# Allow All Outbound Traffic
resource "aws_vpc_security_group_egress_rule" "vpc_b_allow_all" {
  security_group_id = aws_security_group.vpc_b.id
  description       = "Allow all outbound traffic"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

# VPC C Security Group
resource "aws_security_group" "vpc_c" {
  name        = "saa-vpc-c-sg"
  description = "Manages access to private resources for VPC C"
  vpc_id      = aws_vpc.c.id

  tags = {
    Name = "saa-vpc-c-sg"
  }
}

# Allow SG's Inbound Traffic
resource "aws_vpc_security_group_ingress_rule" "vpc_c_allow_self" {
  security_group_id = aws_security_group.vpc_c.id
  description       = "Allow all inbound connections from this SG"

  referenced_security_group_id = aws_security_group.vpc_c.id
  ip_protocol                  = "-1"
}

# Allow Echo Requests From VPC A EC2 Instance
resource "aws_vpc_security_group_ingress_rule" "vpc_c_allow_vpc_a_icmp" {
  security_group_id = aws_security_group.vpc_c.id
  description       = "Allow inbound echo requests from EC2 instance in VPC A"

  cidr_ipv4                    = "${ aws_instance.vpc_a.private_ip }/32"
  ip_protocol                  = "icmp"
  from_port                    = 8
  to_port                      = 0
}

# Allow All Outbound Traffic
resource "aws_vpc_security_group_egress_rule" "vpc_c_allow_all" {
  security_group_id = aws_security_group.vpc_c.id
  description       = "Allow all outbound traffic"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

# --- Interface Endpoints

# Interface VPC Endpoint for SSM
resource "aws_vpc_endpoint" "ssm_a" {
  vpc_id            = aws_vpc.a.id
  service_name      = "com.amazonaws.us-east-1.ssm"
  vpc_endpoint_type = "Interface"

  subnet_ids          = [ aws_subnet.a.id ]
  security_group_ids  = [ aws_security_group.vpc_a.id ]
  private_dns_enabled = true
}

# Interface VPC Endpoint for SSM Messages
resource "aws_vpc_endpoint" "ssm_messages_a" {
  vpc_id            = aws_vpc.a.id
  service_name      = "com.amazonaws.us-east-1.ssmmessages"
  vpc_endpoint_type = "Interface"

  subnet_ids          = [ aws_subnet.a.id ]
  security_group_ids  = [ aws_security_group.vpc_a.id ]
  private_dns_enabled = true
}

# Interface VPC Endpoint for EC2 Messages
resource "aws_vpc_endpoint" "ec2_messages_a" {
  vpc_id            = aws_vpc.a.id
  service_name      = "com.amazonaws.us-east-1.ec2messages"
  vpc_endpoint_type = "Interface"

  subnet_ids          = [ aws_subnet.a.id ]
  security_group_ids  = [ aws_security_group.vpc_a.id ]
  private_dns_enabled = true
}

# --- Peering Connections

# VPC A <> VPC B Peering
resource "aws_vpc_peering_connection" "vpc_a_vpc_b" {
  vpc_id        = aws_vpc.a.id
  peer_vpc_id   = aws_vpc.b.id
  peer_owner_id = data.aws_caller_identity.current.account_id

  tags = {
    Name = "vpc-a-vpc-b"
  }
}

# Acceptance
resource "aws_vpc_peering_connection_accepter" "vpc_a_vpc_b" {
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_a_vpc_b.id
  auto_accept               = true

  tags = {
    Name = "vpc-a-vpc-b"
  }
}

# VPC A Route Table Entry for VPC B
resource "aws_route" "vpc_a_vpc_b" {
  route_table_id            = aws_vpc.a.main_route_table_id
  destination_cidr_block    = aws_vpc.b.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_a_vpc_b.id
}

# VPC B Route Table Entry for VPC A
resource "aws_route" "vpc_b_vpc_a" {
  route_table_id            = aws_vpc.b.main_route_table_id
  destination_cidr_block    = aws_vpc.a.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_a_vpc_b.id
}

# VPC B <> VPC C Peering
resource "aws_vpc_peering_connection" "vpc_b_vpc_c" {
  vpc_id        = aws_vpc.b.id
  peer_vpc_id   = aws_vpc.c.id
  peer_owner_id = data.aws_caller_identity.current.account_id

  tags = {
    Name = "vpc-b-vpc-c"
  }
}

# Acceptance
resource "aws_vpc_peering_connection_accepter" "vpc_b_vpc_c" {
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_b_vpc_c.id
  auto_accept               = true

  tags = {
    Name = "vpc-b-vpc-c"
  }
}

# VPC B Route Table Entry for VPC C
resource "aws_route" "vpc_b_vpc_c" {
  route_table_id            = aws_vpc.b.main_route_table_id
  destination_cidr_block    = aws_vpc.c.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_b_vpc_c.id
}

# VPC C Route Table Entry for VPC B
resource "aws_route" "vpc_c_vpc_b" {
  route_table_id            = aws_vpc.c.main_route_table_id
  destination_cidr_block    = aws_vpc.b.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_b_vpc_c.id
}

# VPC A <> VPC C Peering
resource "aws_vpc_peering_connection" "vpc_a_vpc_c" {
  vpc_id        = aws_vpc.a.id
  peer_vpc_id   = aws_vpc.c.id
  peer_owner_id = data.aws_caller_identity.current.account_id

  tags = {
    Name = "vpc-a-vpc-c"
  }
}

# Acceptance
resource "aws_vpc_peering_connection_accepter" "vpc_a_vpc_c" {
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_a_vpc_c.id
  auto_accept               = true

  tags = {
    Name = "vpc-a-vpc-c"
  }
}

# VPC A Route Table Entry for VPC C
resource "aws_route" "vpc_a_vpc_c" {
  route_table_id            = aws_vpc.a.main_route_table_id
  destination_cidr_block    = aws_vpc.c.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_a_vpc_c.id
}

# VPC C Route Table Entry for VPC A
resource "aws_route" "vpc_c_vpc_a" {
  route_table_id            = aws_vpc.c.main_route_table_id
  destination_cidr_block    = aws_vpc.a.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_a_vpc_c.id
}

