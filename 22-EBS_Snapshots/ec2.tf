
# █▀▀ █░░ ▄▀█ █▀ ▀█▀ █ █▀▀   █▀▀ █▀█ █▀▄▀█ █▀█ █░█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ██▄ █▄▄ █▀█ ▄█ ░█░ █ █▄▄   █▄▄ █▄█ █░▀░█ █▀▀ █▄█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# EC2 Instance A1
module "ec2_instance_a1" {
  source = "../00-Shared_Resources/ec2_module"

  # General
  ec2_name            = "saa-ebs-instance-a1"
  vpc_id              = module.saa_vpc_1.vpc.id
  subnet_id           = module.saa_vpc_1.subnet_web_a.id

  # SSH / SSM
  ssm_session_support = true

  # Public IPs
  auto_assign_ipv4    = true
}

# EC2 Instance A2
module "ec2_instance_a2" {
  source = "../00-Shared_Resources/ec2_module"

  # General
  ec2_name            = "saa-ebs-instance-a2"
  vpc_id              = module.saa_vpc_1.vpc.id
  subnet_id           = module.saa_vpc_1.subnet_web_a.id

  # SSH / SSM
  ssm_session_support = true

  # Public IPs
  auto_assign_ipv4    = true
}

# EC2 Instance B1
module "ec2_instance_b1" {
  source = "../00-Shared_Resources/ec2_module"

  # General
  ec2_name            = "saa-ebs-instance-b1"
  vpc_id              = module.saa_vpc_1.vpc.id
  subnet_id           = module.saa_vpc_1.subnet_web_b.id

  # SSH / SSM
  ssm_session_support = true

  # Public IPs
  auto_assign_ipv4    = true
}

# EC2 M5 Instance
# NOTE: !! not free tier !!
# module "ec2_instance_m5" {
#   source = "../00-Shared_Resources/ec2_module"
#
#   # General
#   ec2_name          = "saa-instance-store-test"
#   ec2_instance_type = "m5dn.large"
#   vpc_id            = module.saa_vpc_1.vpc.id
#   subnet_id         = module.saa_vpc_1.subnet_web_a.id
#
#   # SSH / SSM
#   ssm_session_support = true
#
#   # Public IPs
#   auto_assign_ipv4 = true
# }

# EBS Test Volume
# resource "aws_ebs_volume" "test_vol" {
#   type              = "gp3"
#   size              = 10
#   iops              = 3000
#   throughput        = 125
#   availability_zone = "us-east-1a"
#
#   tags = {
#     Name = "ebs-test-volume"
#   }
# }

# EBS Test Volume Attachment
# resource "aws_volume_attachment" "test_vol_a1" {
#   volume_id   = aws_ebs_volume.test_vol.id
#   instance_id = module.ec2_instance_a2.ec2_instance.id
#   device_name = "/dev/sdf"
# }

# EBS Test Volume Snapshot
# resource "aws_ebs_snapshot" "test_vol" {
#   volume_id = aws_ebs_volume.test_vol.id
#
#   tags = {
#     Name = "ebs-test-snap"
#   }
# }

# EBS Test Volume Copy to AZ B
# resource "aws_ebs_volume" "test_vol_b1" {
#   type              = "gp3"
#   size              = 10
#   iops              = 3000
#   throughput        = 125
#   availability_zone = "us-east-1b"
#   snapshot_id       = aws_ebs_snapshot.test_vol.id
#
#   tags = {
#     Name = "ebs-test-volume-b"
#   }
# }

# EBS Test Volume Attachment B1
# resource "aws_volume_attachment" "test_vol_b1" {
#   volume_id   = aws_ebs_volume.test_vol_b1.id
#   instance_id = module.ec2_instance_b1.ec2_instance.id
#   device_name = "/dev/sdf"
# }

