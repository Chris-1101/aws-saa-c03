
# █▀▀ █░░ ▄▀█ █▀ ▀█▀ █ █▀▀   █▀▀ █▀█ █▀▄▀█ █▀█ █░█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ██▄ █▄▄ █▀█ ▄█ ░█░ █ █▄▄   █▄▄ █▄█ █░▀░█ █▀▀ █▄█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# Wordpress Instance 1
module "ec2_wordpress_1" {
  source = "../00-Shared_Resources/ec2_module"

  # General
  ec2_name            = "saa-wordpress-1"
  ec2_ami             = data.aws_ssm_parameter.latest_al2023.value
  vpc_id              = module.saa_vpc_1.vpc.id
  subnet_id           = module.saa_vpc_1.subnet_web_a.id

  # User Data
  ec2_user_data       = templatefile("wordpress.sh", {
    cw_config_param   = aws_ssm_parameter.cw_agent_config.name
    efs_filesystem_id = aws_efs_file_system.this.id
    rds_hostname      = aws_db_instance.a4l_wordpress.address
  })

  # SSH / SSM
  ssm_session_support = true

  # Public IPs
  auto_assign_ipv4    = true
}

# Wordpress Instance 2
module "ec2_wordpress_2" {
  source = "../00-Shared_Resources/ec2_module"

  # General
  ec2_name            = "saa-wordpress-2"
  ec2_ami             = data.aws_ssm_parameter.latest_al2023.value
  vpc_id              = module.saa_vpc_1.vpc.id
  subnet_id           = module.saa_vpc_1.subnet_web_b.id

  # User Data
  ec2_user_data       = templatefile("wordpress.sh", {
    cw_config_param   = aws_ssm_parameter.cw_agent_config.name
    efs_filesystem_id = aws_efs_file_system.this.id
    rds_hostname      = aws_db_instance.a4l_wordpress.address
  })

  # SSH / SSM
  ssm_session_support = true

  # Public IPs
  auto_assign_ipv4    = true
}

