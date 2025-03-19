
# █▀▀ █░░ ▄▀█ █▀ ▀█▀ █ █▀▀   █▀▀ █▀█ █▀▄▀█ █▀█ █░█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ██▄ █▄▄ █▀█ ▄█ ░█░ █ █▄▄   █▄▄ █▄█ █░▀░█ █▀▀ █▄█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# Wordpress Instance
module "ec2_wordpress" {
  source = "../00-Shared_Resources/ec2_module"

  # General
  ec2_name            = "saa-wordpress"
  ec2_ami             = data.aws_ssm_parameter.latest_al2023.value
  vpc_id              = module.saa_vpc_1.vpc.id
  subnet_id           = module.saa_vpc_1.subnet_web_a.id
  ec2_user_data       = templatefile("wordpress.sh", {
    db_dns            = aws_db_instance.a4l_wordpress.address
  })

  # SSH / SSM
  ssm_session_support = true

  # Public IPs
  auto_assign_ipv4    = true
}

# --- NOTE: an elastic IP is provisioned in the CFN template, but there seems to be no use for it

# Elastic IP
# resource "aws_eip" "wordpress" {
#   domain               = "vpc"
#   network_border_group = "us-east-1"
#   public_ipv4_pool     = "amazon"
#
#   depends_on = [ module.saa_vpc_1.igw ]
# }

# Elastic IP Association
# resource "aws_eip_association" "ec2_wordpress" {
#   allocation_id = aws_eip.wordpress.id
#   instance_id   = module.ec2_wordpress.ec2_instance.id
# }

