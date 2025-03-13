
# █▀▀ █░░ ▄▀█ █▀ ▀█▀ █ █▀▀   █▀▀ █▀█ █▀▄▀█ █▀█ █░█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ██▄ █▄▄ █▀█ ▄█ ░█░ █ █▄▄   █▄▄ █▄█ █░▀░█ █▀▀ █▄█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# EC2 Instance
module "ec2_instance" {
  source = "../00-Shared_Resources/ec2_module"

  # General
  ec2_name  = "saa-docker"
  vpc_id    = module.saa_vpc_1.vpc.id
  subnet_id = module.saa_vpc_1.subnet_web_a.id

  # User Data
  ec2_user_data = file("user-data.sh")

  # SSH / SSM
  ssm_session_support = true

  # Public IPs
  auto_assign_ipv4    = true
}

