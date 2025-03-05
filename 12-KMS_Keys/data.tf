
# █▀▄ ▄▀█ ▀█▀ ▄▀█   █▀ █▀█ █░█ █▀█ █▀▀ █▀▀ █▀ 
# █▄▀ █▀█ ░█░ █▀█   ▄█ █▄█ █▄█ █▀▄ █▄▄ ██▄ ▄█ 

# AWS Account
data "aws_caller_identity" "this" {}

# IAM Admin User
data "aws_iam_user" "admin" {
  user_name = "iam-admin"
}

