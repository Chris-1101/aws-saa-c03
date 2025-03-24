
# █ █▀▄ █▀▀ █▄░█ ▀█▀ █ ▀█▀ █▄█   ▄▀█ █▀▀ █▀▀ █▀▀ █▀ █▀   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀ 
# █ █▄▀ ██▄ █░▀█ ░█░ █ ░█░ ░█░   █▀█ █▄▄ █▄▄ ██▄ ▄█ ▄█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░ 

# EC2 Instance Profile
resource "aws_iam_instance_profile" "ec2_web" {
  name = "saa-web-profile"
  role = aws_iam_role.ec2_web.name
}

# EC2 Instance Role
resource "aws_iam_role" "ec2_web" {
  name               = "saa-web-role"
  path               = "/"
  assume_role_policy = file("json/trust-policy.json")
}

# Attach SSM Session Manager Policy
resource "aws_iam_role_policy_attachment" "ssm_session_manager" {
  role       = aws_iam_role.ec2_web.name
  policy_arn = data.aws_iam_policy.ssm_session_manager.arn
}

