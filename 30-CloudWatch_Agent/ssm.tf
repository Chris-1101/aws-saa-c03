
# █▀ █▄█ █▀ ▀█▀ █▀▀ █▀▄▀█ █▀   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀█ 
# ▄█ ░█░ ▄█ ░█░ ██▄ █░▀░█ ▄█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █▀▄ 

# NOTE: wouldn't normally terraform this, just following the CloudFormation template

resource "aws_ssm_parameter" "db_name" {
  name  = "/saa/a4l/db_name"
  type  = "String"
  value = var.db_name
}

resource "aws_ssm_parameter" "db_user" {
  name  = "/saa/a4l/db_user"
  type  = "String"
  value = var.db_user
}

resource "aws_ssm_parameter" "db_pass" {
  name  = "/saa/a4l/db_pass"
  type  = "SecureString"
  value = sensitive(var.db_pass)
}

resource "aws_ssm_parameter" "db_root_pass" {
  name  = "/saa/a4l/db_root_pass"
  type  = "SecureString"
  value = sensitive(var.db_root_pass)
}

