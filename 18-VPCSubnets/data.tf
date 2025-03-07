
# █▀▄ ▄▀█ ▀█▀ ▄▀█   █▀ █▀█ █░█ █▀█ █▀▀ █▀▀ █▀ 
# █▄▀ █▀█ ░█░ █▀█   ▄█ █▄█ █▄█ █▀▄ █▄▄ ██▄ ▄█ 

# VPC
data "aws_vpc" "saa_vpc_1" {
  cidr_block = "10.16.0.0/16"
}

# AWS Account
# data "aws_caller_identity" "this" {}

# IAM Admin User
# data "aws_iam_user" "admin" {
#   user_name = "iam-admin"
# }

