
# █▀▀ █░░ ▄▀█ █▀ ▀█▀ █ █▀▀   █▀▀ █▀█ █▀▄▀█ █▀█ █░█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ██▄ █▄▄ █▀█ ▄█ ░█░ █ █▄▄   █▄▄ █▄█ █░▀░█ █▀▀ █▄█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# EC2 Instance
module "ec2_instance" {
  source = "../00-Shared_Resources/ec2_module"

  # General
  ec2_name            = "saa-cloudwatch-agent"
  ec2_ami             = data.aws_ssm_parameter.ami_al2023_latest.value
  vpc_id              = module.saa_vpc_1.vpc.id
  subnet_id           = module.saa_vpc_1.subnet_web_a.id
  ec2_user_data       = file("user-data.sh")

  # SSH / SSM
  ssm_session_support = true

  # Public IPs
  auto_assign_ipv4    = true

  # Dependencies
  depends_on = [
    aws_ssm_parameter.db_name,
    aws_ssm_parameter.db_user,
    aws_ssm_parameter.db_pass,
    aws_ssm_parameter.db_root_pass
  ]
}

