
# █░█ █ █▀█ ▀█▀ █░█ ▄▀█ █░░   █▀█ █▀█ █ █░█ ▄▀█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ▀▄▀ █ █▀▄ ░█░ █▄█ █▀█ █▄▄   █▀▀ █▀▄ █ ▀▄▀ █▀█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# SAA Reserved A
resource "aws_subnet" "reserved_a" {
  vpc_id = data.aws_vpc.saa_vpc_1.id

  availability_zone = "us-east-1a"
  cidr_block        = "10.16.0.0/20"
  ipv6_cidr_block   = "2600:1f10:451f:c400::/64"

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "saa-reserved-a"
  }
}

# SAA DB A
resource "aws_subnet" "db_a" {
  vpc_id = data.aws_vpc.saa_vpc_1.id

  availability_zone = "us-east-1a"
  cidr_block        = "10.16.16.0/20"
  ipv6_cidr_block   = "2600:1f10:451f:c401::/64"

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "saa-db-a"
  }
}

# SAA App A
resource "aws_subnet" "app_a" {
  vpc_id = data.aws_vpc.saa_vpc_1.id

  availability_zone = "us-east-1a"
  cidr_block        = "10.16.32.0/20"
  ipv6_cidr_block   = "2600:1f10:451f:c402::/64"

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "saa-app-a"
  }
}

# SAA Web A
resource "aws_subnet" "web_a" {
  vpc_id = data.aws_vpc.saa_vpc_1.id

  availability_zone = "us-east-1a"
  cidr_block        = "10.16.48.0/20"
  ipv6_cidr_block   = "2600:1f10:451f:c403::/64"

  map_public_ip_on_launch         = true   # Part of VPC Routing Demo
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "saa-web-a"
  }
}

# SAA Reserved B
resource "aws_subnet" "reserved_b" {
  vpc_id = data.aws_vpc.saa_vpc_1.id

  availability_zone = "us-east-1b"
  cidr_block        = "10.16.64.0/20"
  ipv6_cidr_block   = "2600:1f10:451f:c404::/64"

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "saa-reserved-b"
  }
}

# SAA DB B
resource "aws_subnet" "db_b" {
  vpc_id = data.aws_vpc.saa_vpc_1.id

  availability_zone = "us-east-1b"
  cidr_block        = "10.16.80.0/20"
  ipv6_cidr_block   = "2600:1f10:451f:c405::/64"

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "saa-db-b"
  }
}

# SAA App B
resource "aws_subnet" "app_b" {
  vpc_id = data.aws_vpc.saa_vpc_1.id

  availability_zone = "us-east-1b"
  cidr_block        = "10.16.96.0/20"
  ipv6_cidr_block   = "2600:1f10:451f:c406::/64"

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "saa-app-b"
  }
}

# SAA Web B
resource "aws_subnet" "web_b" {
  vpc_id = data.aws_vpc.saa_vpc_1.id

  availability_zone = "us-east-1b"
  cidr_block        = "10.16.112.0/20"
  ipv6_cidr_block   = "2600:1f10:451f:c407::/64"

  map_public_ip_on_launch         = true   # Part of VPC Routing Demo
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "saa-web-b"
  }
}

# SAA Reserved C
resource "aws_subnet" "reserved_c" {
  vpc_id = data.aws_vpc.saa_vpc_1.id

  availability_zone = "us-east-1c"
  cidr_block        = "10.16.128.0/20"
  ipv6_cidr_block   = "2600:1f10:451f:c408::/64"

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "saa-reserved-c"
  }
}

# SAA DB C
resource "aws_subnet" "db_c" {
  vpc_id = data.aws_vpc.saa_vpc_1.id

  availability_zone = "us-east-1c"
  cidr_block        = "10.16.144.0/20"
  ipv6_cidr_block   = "2600:1f10:451f:c409::/64"

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "saa-db-c"
  }
}

# SAA App C
resource "aws_subnet" "app_c" {
  vpc_id = data.aws_vpc.saa_vpc_1.id

  availability_zone = "us-east-1c"
  cidr_block        = "10.16.160.0/20"
  ipv6_cidr_block   = "2600:1f10:451f:c40a::/64"

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "saa-app-c"
  }
}

# SAA Web C
resource "aws_subnet" "web_c" {
  vpc_id = data.aws_vpc.saa_vpc_1.id

  availability_zone = "us-east-1c"
  cidr_block        = "10.16.176.0/20"
  ipv6_cidr_block   = "2600:1f10:451f:c40b::/64"

  map_public_ip_on_launch         = true   # Part of VPC Routing Demo
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "saa-web-c"
  }
}

