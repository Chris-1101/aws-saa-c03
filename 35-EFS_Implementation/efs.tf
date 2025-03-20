
# █▀▀ █░░ ▄▀█ █▀ ▀█▀ █ █▀▀   █▀▀ █ █░░ █▀▀   █▀ █▄█ █▀ ▀█▀ █▀▀ █▀▄▀█ 
# ██▄ █▄▄ █▀█ ▄█ ░█░ █ █▄▄   █▀░ █ █▄▄ ██▄   ▄█ ░█░ ▄█ ░█░ ██▄ █░▀░█ 

# EFS Filesystem
resource "aws_efs_file_system" "this" {
  creation_token   = "saa-efs"
  encrypted        = false
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }

  lifecycle_policy {
    transition_to_primary_storage_class = "AFTER_1_ACCESS"
  }

  tags = {
    Name = "saa-efs"
  }
}

# Subnet App A
resource "aws_efs_mount_target" "app_a" {
  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = module.saa_vpc_1.subnet_app_a.id
  security_groups = [
    module.ec2_efs_a.ec2_sg.id,
    module.ec2_efs_b.ec2_sg.id
  ]
}

# Subnet App B
resource "aws_efs_mount_target" "app_b" {
  file_system_id = aws_efs_file_system.this.id
  subnet_id      = module.saa_vpc_1.subnet_app_b.id
  security_groups = [
    module.ec2_efs_a.ec2_sg.id,
    module.ec2_efs_b.ec2_sg.id
  ]
}

# Subnet App C
resource "aws_efs_mount_target" "app_c" {
  file_system_id = aws_efs_file_system.this.id
  subnet_id      = module.saa_vpc_1.subnet_app_c.id
  security_groups = [
    module.ec2_efs_a.ec2_sg.id,
    module.ec2_efs_b.ec2_sg.id
  ]
}

