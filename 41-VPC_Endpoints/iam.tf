
# █ █▀▄ █▀▀ █▄░█ ▀█▀ █ ▀█▀ █▄█   ▄▀█ █▀▀ █▀▀ █▀▀ █▀ █▀   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀ 
# █ █▄▀ ██▄ █░▀█ ░█░ █ ░█░ ░█░   █▀█ █▄▄ █▄▄ ██▄ ▄█ ▄█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░ 

# EC2 Instance Profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "saa-private-instance-profile"
  role = aws_iam_role.ec2_role.name
}

# SSM Access Role
resource "aws_iam_role" "ec2_role" {
  name               = "saa-private-instance-role"
  assume_role_policy = file("json/trust-policy.json")
}

# Attach SSM Managed Instance Core policy to instance role
resource "aws_iam_role_policy_attachment" "ec2_ssm_managed_instance_core" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = data.aws_iam_policy.ssm_managed_instance_core.arn
}

# Attach S3 Full Access policy to instance role
resource "aws_iam_role_policy_attachment" "ec2_s3_full_access" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = data.aws_iam_policy.s3_full_access.arn
}

