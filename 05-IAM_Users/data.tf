
# █▀▄ ▄▀█ ▀█▀ ▄▀█   █▀ █▀█ █░█ █▀█ █▀▀ █▀▀ █▀ 
# █▄▀ █▀█ ░█░ █▀█   ▄█ █▄█ █▄█ █▀▄ █▄▄ ██▄ ▄█ 

# SSM Managed Instance Core Policy
data "aws_iam_policy" "iam_user_change_password" {
  arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}

