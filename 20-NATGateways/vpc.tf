
# █░█ █ █▀█ ▀█▀ █░█ ▄▀█ █░░   █▀█ █▀█ █ █░█ ▄▀█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ▀▄▀ █ █▀▄ ░█░ █▄█ █▀█ █▄▄   █▀▀ █▀▄ █ ▀▄▀ █▀█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# VPC
module "saa_vpc_1" {
  source = "../00-Shared_Resources/vpc_module"
  vpc_name = "saa-vpc-1"
}


# ------- VPC Interface Endpoints -------

# Interface VPC Endpoint for SSM
resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = module.saa_vpc_1.vpc.id
  service_name      = "com.amazonaws.us-east-1.ssm"
  vpc_endpoint_type = "Interface"

  subnet_ids = [
    module.saa_vpc_1.subnet_app_a.id,
    module.saa_vpc_1.subnet_app_b.id,
    module.saa_vpc_1.subnet_app_c.id
  ]

  security_group_ids = [ module.ec2_instance.ec2_sg.id ]

  private_dns_enabled = true
}

# Interface VPC Endpoint for SSM Messages
resource "aws_vpc_endpoint" "ssm_messages" {
  vpc_id            = module.saa_vpc_1.vpc.id
  service_name      = "com.amazonaws.us-east-1.ssmmessages"
  vpc_endpoint_type = "Interface"

  subnet_ids = [
    module.saa_vpc_1.subnet_app_a.id,
    module.saa_vpc_1.subnet_app_b.id,
    module.saa_vpc_1.subnet_app_c.id
  ]

  security_group_ids = [ module.ec2_instance.ec2_sg.id ]

  private_dns_enabled = true
}

# Interface VPC Endpoint for EC2 Messages
resource "aws_vpc_endpoint" "ec2_messages" {
  vpc_id            = module.saa_vpc_1.vpc.id
  service_name      = "com.amazonaws.us-east-1.ec2messages"
  vpc_endpoint_type = "Interface"

  subnet_ids = [
    module.saa_vpc_1.subnet_app_a.id,
    module.saa_vpc_1.subnet_app_b.id,
    module.saa_vpc_1.subnet_app_c.id
  ]

  security_group_ids = [ module.ec2_instance.ec2_sg.id ]

  private_dns_enabled = true
}


# ------- NAT Gateways -------

# NAT Gateway for Subnet Web A
resource "aws_nat_gateway" "a" {
  subnet_id         = module.saa_vpc_1.subnet_web_a.id
  connectivity_type = "public"
  allocation_id     = aws_eip.natgw_a.allocation_id

  tags = {
    Name = "saa-vpc-1-natgw-a"
  }

  depends_on = [ module.saa_vpc_1.igw ]
}

# NAT Gateway for Subnet Web B
resource "aws_nat_gateway" "b" {
  subnet_id         = module.saa_vpc_1.subnet_web_b.id
  connectivity_type = "public"
  allocation_id     = aws_eip.natgw_b.allocation_id

  tags = {
    Name = "saa-vpc-1-natgw-b"
  }

  depends_on = [ module.saa_vpc_1.igw ]
}

# NAT Gateway for Subnet Web C
resource "aws_nat_gateway" "c" {
  subnet_id         = module.saa_vpc_1.subnet_web_c.id
  connectivity_type = "public"
  allocation_id     = aws_eip.natgw_c.allocation_id

  tags = {
    Name = "saa-vpc-1-natgw-c"
  }

  depends_on = [ module.saa_vpc_1.igw ]
}


# ------- Private Route Tables -------

# Route Table for Private Subnets A
resource "aws_route_table" "priv_a" {
  vpc_id = module.saa_vpc_1.vpc.id

  tags = {
    Name = "saa-vpc-1-rt-private-a"
  }
}

# Route Table for Private Subnets B
resource "aws_route_table" "priv_b" {
  vpc_id = module.saa_vpc_1.vpc.id

  tags = {
    Name = "saa-vpc-1-rt-private-b"
  }
}

# Route Table for Private Subnets C
resource "aws_route_table" "priv_c" {
  vpc_id = module.saa_vpc_1.vpc.id

  tags = {
    Name = "saa-vpc-1-rt-private-c"
  }
}

# Default IPv4 Route A
resource "aws_route" "nat_a" {
  route_table_id         = aws_route_table.priv_a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.a.id
}

# Default IPv4 Route B
resource "aws_route" "nat_b" {
  route_table_id         = aws_route_table.priv_b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.b.id
}

# Default IPv4 Route C
resource "aws_route" "nat_c" {
  route_table_id         = aws_route_table.priv_c.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.c.id
}

# Route Table Association for App Subnet A
resource "aws_route_table_association" "app_a" {
  subnet_id      = module.saa_vpc_1.subnet_app_a.id
  route_table_id = aws_route_table.priv_a.id
}

# Route Table Association for App Subnet B
resource "aws_route_table_association" "app_b" {
  subnet_id      = module.saa_vpc_1.subnet_app_b.id
  route_table_id = aws_route_table.priv_b.id
}

# Route Table Association for App Subnet C
resource "aws_route_table_association" "app_c" {
  subnet_id      = module.saa_vpc_1.subnet_app_c.id
  route_table_id = aws_route_table.priv_c.id
}

# Route Table Association for DB Subnet A
resource "aws_route_table_association" "db_a" {
  subnet_id      = module.saa_vpc_1.subnet_db_a.id
  route_table_id = aws_route_table.priv_a.id
}

# Route Table Association for DB Subnet B
resource "aws_route_table_association" "db_b" {
  subnet_id      = module.saa_vpc_1.subnet_db_b.id
  route_table_id = aws_route_table.priv_b.id
}

# Route Table Association for DB Subnet C
resource "aws_route_table_association" "db_c" {
  subnet_id      = module.saa_vpc_1.subnet_db_c.id
  route_table_id = aws_route_table.priv_c.id
}

# Route Table Association for Reserved Subnet A
resource "aws_route_table_association" "reserved_a" {
  subnet_id      = module.saa_vpc_1.subnet_reserved_a.id
  route_table_id = aws_route_table.priv_a.id
}

# Route Table Association for Reserved Subnet B
resource "aws_route_table_association" "reserved_b" {
  subnet_id      = module.saa_vpc_1.subnet_reserved_b.id
  route_table_id = aws_route_table.priv_b.id
}

# Route Table Association for Reserved Subnet C
resource "aws_route_table_association" "reserved_c" {
  subnet_id      = module.saa_vpc_1.subnet_reserved_c.id
  route_table_id = aws_route_table.priv_c.id
}

