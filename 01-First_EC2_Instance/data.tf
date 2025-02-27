
# █▀▄ ▄▀█ ▀█▀ ▄▀█   █▀ █▀█ █░█ █▀█ █▀▀ █▀▀ █▀ 
# █▄▀ █▀█ ░█░ █▀█   ▄█ █▄█ █▄█ █▀▄ █▄▄ ██▄ ▄█ 

# EC2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = [ "amazon" ]

  filter {
    name   = "name"
    values = [ "al2023-ami-2023.*-x86_64" ]
  }
}

# SSH Public Key
data "aws_key_pair" "operations" {
  key_name = local.ssh_key
}

# Default VPC
data "aws_vpc" "default" {
  default = true
}

# Subnet
data "aws_subnet" "selected" {
  vpc_id            = data.aws_vpc.default.id
  availability_zone = "us-east-1a"
  default_for_az    = true
}

