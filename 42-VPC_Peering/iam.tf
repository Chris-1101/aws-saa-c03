
# █ █▀▄ █▀▀ █▄░█ ▀█▀ █ ▀█▀ █▄█   ▄▀█ █▀▀ █▀▀ █▀▀ █▀ █▀   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀ 
# █ █▄▀ ██▄ █░▀█ ░█░ █ ░█░ ░█░   █▀█ █▄▄ █▄▄ ██▄ ▄█ ▄█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░ 

# EC2 Instance Profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "saa-vpc_demo-profile"
  role = aws_iam_role.ec2.name
}

# SSM Access Role
resource "aws_iam_role" "ec2" {
  name               = "saa-vpc-demo-role"
  assume_role_policy = file("json/trust-policy.json")
}

# Attach SSM Managed Instance Core Policy
resource "aws_iam_role_policy_attachment" "ec2_ssm_managed_instance_core" {
  role       = aws_iam_role.ec2.name
  policy_arn = data.aws_iam_policy.ssm_managed_instance_core.arn
}

# Attach S3 Full Access Policy
resource "aws_iam_role_policy_attachment" "ec2_s3_full_access" {
  role       = aws_iam_role.ec2.name
  policy_arn = data.aws_iam_policy.s3_full_access.arn
}

# Attach SNS Full Access Policy
resource "aws_iam_role_policy_attachment" "ec2_sns_full_access" {
  role       = aws_iam_role.ec2.name
  policy_arn = data.aws_iam_policy.sns_full_access.arn
}

