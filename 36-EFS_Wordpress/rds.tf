
# █▀█ █▀▀ █░░ ▄▀█ ▀█▀ █ █▀█ █▄░█ ▄▀█ █░░   █▀▄ ▄▀█ ▀█▀ ▄▀█ █▄▄ ▄▀█ █▀ █▀▀   █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ 
# █▀▄ ██▄ █▄▄ █▀█ ░█░ █ █▄█ █░▀█ █▀█ █▄▄   █▄▀ █▀█ ░█░ █▀█ █▄█ █▀█ ▄█ ██▄   ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ 

# RDS Instance
resource "aws_db_instance" "a4l_wordpress" {

  # Instance
  identifier        = var.rds_name
  instance_class    = "db.t4g.micro"
  storage_type      = "gp2"
  allocated_storage = 20   # GB
  storage_encrypted = true

  # Database
  engine               = "mysql"
  engine_version       = "8.0.32"
  db_name              = var.db_name
  parameter_group_name = "default.mysql8.0"
  option_group_name    = "default:mysql-8-0"

  # Credentials
  username = var.db_user
  password = var.db_pass

  # Network
  ca_cert_identifier     = "rds-ca-rsa2048-g1"
  db_subnet_group_name   = aws_db_subnet_group.saa_db.name
  multi_az               = false
  publicly_accessible    = false
  network_type           = "IPV4"
  vpc_security_group_ids = [ aws_security_group.rds.id ]

  # Backups
  backup_retention_period  = 1   # day(s)
  copy_tags_to_snapshot    = true
  skip_final_snapshot      = true
  delete_automated_backups = true

  # Maintenance
  auto_minor_version_upgrade  = true
  allow_major_version_upgrade = false

  # RDS Extended Support
  engine_lifecycle_support = "open-source-rds-extended-support-disabled"

  # Monitoring
  monitoring_interval = 0   # Disable enhanced monitoring
}

# RDS Subnet Group
resource "aws_db_subnet_group" "saa_db" {
  name        = "saa-sn-group"
  description = "DB subnets for saa-vpc-1"

  subnet_ids = [
    module.saa_vpc_1.subnet_db_a.id,
    module.saa_vpc_1.subnet_db_b.id,
    module.saa_vpc_1.subnet_db_c.id
  ]

  tags = {
    Name = "saa-sn-group"
  }
}

