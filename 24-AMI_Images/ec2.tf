
# █▀▀ █░░ ▄▀█ █▀ ▀█▀ █ █▀▀   █▀▀ █▀█ █▀▄▀█ █▀█ █░█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ██▄ █▄▄ █▀█ ▄█ ░█░ █ █▄▄   █▄▄ █▄█ █░▀░█ █▀▀ █▄█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# EC2 Instance
module "ec2_instance" {
  source = "../00-Shared_Resources/ec2_module"

  # General
  ec2_name            = "saa-wordpress"
  vpc_id              = module.saa_vpc_1.vpc.id
  subnet_id           = module.saa_vpc_1.subnet_web_a.id

  # SSH / SSM
  ssm_session_support = true

  # Public IPs
  auto_assign_ipv4    = true
}

# Wordpress AMI
# resource "aws_ami_from_instance" "saa_wordpress" {
#   name               = "saa-wordpress"
#   source_instance_id = module.ec2_instance.ec2_instance.id
# }

# EC2 Instance from AMI
# module "ec2_instance_2" {
#   source = "../00-Shared_Resources/ec2_module"
#
#   # General
#   ec2_name            = "saa-wordpress-2"
#   ec2_ami             = aws_ami_from_instance.saa_wordpress.id
#   vpc_id              = module.saa_vpc_1.vpc.id
#   subnet_id           = module.saa_vpc_1.subnet_web_a.id
#
#   # SSH / SSM
#   ssm_session_support = true
#
#   # Public IPs
#   auto_assign_ipv4    = true
# }

