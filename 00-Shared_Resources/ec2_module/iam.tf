
# █ █▀▄ █▀▀ █▄░█ ▀█▀ █ ▀█▀ █▄█   ▄▀█ █▀▀ █▀▀ █▀▀ █▀ █▀   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀ 
# █ █▄▀ ██▄ █░▀█ ░█░ █ ░█░ ░█░   █▀█ █▄▄ █▄▄ ██▄ ▄█ ▄█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░ 

# EC2 Instance Profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${ var.ec2_name }-profile"
  role = aws_iam_role.ec2_role.name
}

# SSM Access Role
resource "aws_iam_role" "ec2_role" {
  name               = "${ var.ec2_name }-role"
  path               = "/"
  assume_role_policy = file("${ path.module }/json/trust-policy.json")
}

# Attach SSM Managed Instance Core policy to instance role
resource "aws_iam_role_policy_attachment" "ec2_ssm_managed_instance_core" {
  count      = var.ssm_session_support ? 1 : 0
  role       = aws_iam_role.ec2_role.name
  policy_arn = data.aws_iam_policy.ssm_managed_instance_core.arn
}

