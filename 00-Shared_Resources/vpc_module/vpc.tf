
# █░█ █ █▀█ ▀█▀ █░█ ▄▀█ █░░   █▀█ █▀█ █ █░█ ▄▀█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ▀▄▀ █ █▀▄ ░█░ █▄█ █▀█ █▄▄   █▀▀ █▀▄ █ ▀▄▀ █▀█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# VPC
resource "aws_vpc" "this" {
  cidr_block = "10.16.0.0/16"

  # IPv6 CIDR Block
  assign_generated_ipv6_cidr_block     = true
  ipv6_cidr_block_network_border_group = "us-east-1"

  # Instance Tenancy
  instance_tenancy = "default"

  # DNS
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name
  }
}


# ------- VPC Subnets -------

# SAA Reserved A
resource "aws_subnet" "reserved_a" {
  vpc_id = aws_vpc.this.id

  availability_zone = "us-east-1a"
  cidr_block        = "10.16.0.0/20"
  ipv6_cidr_block   = replace(aws_vpc.this.ipv6_cidr_block, "00::/56", "00::/64")

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "saa-reserved-a"
  }
}

# SAA DB A
resource "aws_subnet" "db_a" {
  vpc_id = aws_vpc.this.id

  availability_zone = "us-east-1a"
  cidr_block        = "10.16.16.0/20"
  ipv6_cidr_block   = replace(aws_vpc.this.ipv6_cidr_block, "00::/56", "01::/64")

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "saa-db-a"
  }
}

# SAA App A
resource "aws_subnet" "app_a" {
  vpc_id = aws_vpc.this.id

  availability_zone = "us-east-1a"
  cidr_block        = "10.16.32.0/20"
  ipv6_cidr_block   = replace(aws_vpc.this.ipv6_cidr_block, "00::/56", "02::/64")

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "saa-app-a"
  }
}

# SAA Web A
resource "aws_subnet" "web_a" {
  vpc_id = aws_vpc.this.id

  availability_zone = "us-east-1a"
  cidr_block        = "10.16.48.0/20"
  ipv6_cidr_block   = replace(aws_vpc.this.ipv6_cidr_block, "00::/56", "03::/64")

  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "saa-web-a"
  }
}

# SAA Reserved B
resource "aws_subnet" "reserved_b" {
  vpc_id = aws_vpc.this.id

  availability_zone = "us-east-1b"
  cidr_block        = "10.16.64.0/20"
  ipv6_cidr_block   = replace(aws_vpc.this.ipv6_cidr_block, "00::/56", "04::/64")

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "saa-reserved-b"
  }
}

# SAA DB B
resource "aws_subnet" "db_b" {
  vpc_id = aws_vpc.this.id

  availability_zone = "us-east-1b"
  cidr_block        = "10.16.80.0/20"
  ipv6_cidr_block   = replace(aws_vpc.this.ipv6_cidr_block, "00::/56", "05::/64")

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "saa-db-b"
  }
}

# SAA App B
resource "aws_subnet" "app_b" {
  vpc_id = aws_vpc.this.id

  availability_zone = "us-east-1b"
  cidr_block        = "10.16.96.0/20"
  ipv6_cidr_block   = replace(aws_vpc.this.ipv6_cidr_block, "00::/56", "06::/64")

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "saa-app-b"
  }
}

# SAA Web B
resource "aws_subnet" "web_b" {
  vpc_id = aws_vpc.this.id

  availability_zone = "us-east-1b"
  cidr_block        = "10.16.112.0/20"
  ipv6_cidr_block   = replace(aws_vpc.this.ipv6_cidr_block, "00::/56", "07::/64")

  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "saa-web-b"
  }
}

# SAA Reserved C
resource "aws_subnet" "reserved_c" {
  vpc_id = aws_vpc.this.id

  availability_zone = "us-east-1c"
  cidr_block        = "10.16.128.0/20"
  ipv6_cidr_block   = replace(aws_vpc.this.ipv6_cidr_block, "00::/56", "08::/64")

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "saa-reserved-c"
  }
}

# SAA DB C
resource "aws_subnet" "db_c" {
  vpc_id = aws_vpc.this.id

  availability_zone = "us-east-1c"
  cidr_block        = "10.16.144.0/20"
  ipv6_cidr_block   = replace(aws_vpc.this.ipv6_cidr_block, "00::/56", "09::/64")

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "saa-db-c"
  }
}

# SAA App C
resource "aws_subnet" "app_c" {
  vpc_id = aws_vpc.this.id

  availability_zone = "us-east-1c"
  cidr_block        = "10.16.160.0/20"
  ipv6_cidr_block   = replace(aws_vpc.this.ipv6_cidr_block, "00::/56", "0a::/64")

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "saa-app-c"
  }
}

# SAA Web C
resource "aws_subnet" "web_c" {
  vpc_id = aws_vpc.this.id

  availability_zone = "us-east-1c"
  cidr_block        = "10.16.176.0/20"
  ipv6_cidr_block   = replace(aws_vpc.this.ipv6_cidr_block, "00::/56", "0b::/64")

  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "saa-web-c"
  }
}


# ------- Internet Gateway -------

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${ var.vpc_name }-igw"
  }
}

# Route Table for Web Subnets
resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${ var.vpc_name }-rt-web"
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
  subnet_id      = aws_subnet.web_a.id
  route_table_id = aws_route_table.this.id
}

# Route Table Association for Web Subnet B
resource "aws_route_table_association" "web_b" {
  subnet_id      = aws_subnet.web_b.id
  route_table_id = aws_route_table.this.id
}

# Route Table Association for Web Subnet C
resource "aws_route_table_association" "web_c" {
  subnet_id      = aws_subnet.web_c.id
  route_table_id = aws_route_table.this.id
}

