
# █▀▀ █░░ ▄▀█ █▀ ▀█▀ █ █▀▀   █▀▀ █▀█ █▀▄▀█ █▀█ █░█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ██▄ █▄▄ █▀█ ▄█ ░█░ █ █▄▄   █▄▄ █▄█ █░▀░█ █▀▀ █▄█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# EFS Instance A
module "ec2_efs_a" {
  source = "../00-Shared_Resources/ec2_module"

  # General
  ec2_name            = "saa-efs-a"
  ec2_ami             = data.aws_ssm_parameter.latest_al2023.value
  vpc_id              = module.saa_vpc_1.vpc.id
  subnet_id           = module.saa_vpc_1.subnet_web_a.id
  ec2_user_data       = file("user-data.sh")

  # SSH / SSM
  ssm_session_support = true

  # Public IPs
  auto_assign_ipv4    = true
}

# EFS Instance B
module "ec2_efs_b" {
  source = "../00-Shared_Resources/ec2_module"

  # General
  ec2_name            = "saa-efs-b"
  ec2_ami             = data.aws_ssm_parameter.latest_al2023.value
  vpc_id              = module.saa_vpc_1.vpc.id
  subnet_id           = module.saa_vpc_1.subnet_web_b.id
  ec2_user_data       = file("user-data.sh")

  # SSH / SSM
  ssm_session_support = true

  # Public IPs
  auto_assign_ipv4    = true
}

