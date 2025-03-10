
# █▀▀ █░░ ▄▀█ █▀ ▀█▀ █ █▀▀   █▀▀ █▀█ █▀▄▀█ █▀█ █░█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ██▄ █▄▄ █▀█ ▄█ ░█░ █ █▄▄   █▄▄ █▄█ █░▀░█ █▀▀ █▄█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# EC2 Instance
module "ec2_instance" {
  source = "../00-Shared_Resources/ec2_module"

  # General
  ec2_name            = "saa-internal-test"
  vpc_id              = module.saa_vpc_1.vpc.id
  subnet_id           = module.saa_vpc_1.subnet_app_a.id

  # SSH / SSM
  ec2_key_name        = data.aws_key_pair.operations.key_name
  ssm_session_support = true

  # Public IPs
  auto_assign_ipv4    = false
}

# Elastic IP for Web A NATGW
resource "aws_eip" "natgw_a" {
  domain               = "vpc"
  network_border_group = "us-east-1"
  public_ipv4_pool     = "amazon"

  depends_on = [ module.saa_vpc_1.igw ]
}

# Elastic IP for Web B NATGW
resource "aws_eip" "natgw_b" {
  domain               = "vpc"
  network_border_group = "us-east-1"
  public_ipv4_pool     = "amazon"

  depends_on = [ module.saa_vpc_1.igw ]
}

# Elastic IP for Web C NATGW
resource "aws_eip" "natgw_c" {
  domain               = "vpc"
  network_border_group = "us-east-1"
  public_ipv4_pool     = "amazon"

  depends_on = [ module.saa_vpc_1.igw ]
}

