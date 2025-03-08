
# █▀▄ ▄▀█ ▀█▀ ▄▀█   █▀ █▀█ █░█ █▀█ █▀▀ █▀▀ █▀ 
# █▄▀ █▀█ ░█░ █▀█   ▄█ █▄█ █▄█ █▀▄ █▄▄ ██▄ ▄█ 

# SAA VPC
data "aws_vpc" "saa_vpc_1" {
  cidr_block = "10.16.0.0/16"
}

# SAA Web Subnet A
data "aws_subnet" "saa_web_a" {
  vpc_id = data.aws_vpc.saa_vpc_1.id

  filter {
    name = "tag:Name"
    values = [ "saa-web-a" ]
  }
}

# SAA Web Subnet B
data "aws_subnet" "saa_web_b" {
  vpc_id = data.aws_vpc.saa_vpc_1.id

  filter {
    name = "tag:Name"
    values = [ "saa-web-b" ]
  }
}

# SAA Web Subnet C
data "aws_subnet" "saa_web_c" {
  vpc_id = data.aws_vpc.saa_vpc_1.id

  filter {
    name = "tag:Name"
    values = [ "saa-web-c" ]
  }
}

# EC2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = [ "amazon" ]

  filter {
    name   = "name"
    values = [ "al2023-ami-2023.*-x86_64" ]
  }
}

# SSH Public Key
data "aws_key_pair" "operations" {
  key_name = "operations"
}

# SSM Managed Instance Core Policy
data "aws_iam_policy" "ssm_managed_instance_core" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

