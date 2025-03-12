
# █▀▀ █░░ ▄▀█ █▀ ▀█▀ █ █▀▀   █▀▀ █▀█ █▀▄▀█ █▀█ █░█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ██▄ █▄▄ █▀█ ▄█ ░█░ █ █▄▄   █▄▄ █▄█ █░▀░█ █▀▀ █▄█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# EC2 Instance
module "ec2_instance" {
  source = "../00-Shared_Resources/ec2_module"

  # General
  ec2_name            = "saa-metadata"
  vpc_id              = module.saa_vpc_1.vpc.id
  subnet_id           = module.saa_vpc_1.subnet_web_a.id

  # SSH / SSM
  ssm_session_support = true

  # Public IPs
  auto_assign_ipv4    = true
}

# NOTE: With IMDSv2, an authentication token is required
#
#  This can be trieved with:
#   TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
#
#  And set in the header of requests:
#   curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/...
#
#  Docs: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-instance-metadata-service.html

