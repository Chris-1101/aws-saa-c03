
# █ █▀▄ █▀▀ █▄░█ ▀█▀ █ ▀█▀ █▄█   ▄▀█ █▀▀ █▀▀ █▀▀ █▀ █▀   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀ 
# █ █▄▀ ██▄ █░▀█ ░█░ █ ░█░ ░█░   █▀█ █▄▄ █▄▄ ██▄ ▄█ ▄█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░ 

# Attach Elastic File System Policy (EFS-A)
resource "aws_iam_role_policy_attachment" "efs_client_a" {
  role       = module.ec2_efs_a.ec2_role.name
  policy_arn = data.aws_iam_policy.efs_client.arn
}

# Attach SSM Full Access Policy (EFS-A)
resource "aws_iam_role_policy_attachment" "ssm_full_a" {
  role       = module.ec2_efs_a.ec2_role.name
  policy_arn = data.aws_iam_policy.ssm_full.arn
}

# Attach Elastic File System Policy (EFS-B)
resource "aws_iam_role_policy_attachment" "efs_client_b" {
  role       = module.ec2_efs_b.ec2_role.name
  policy_arn = data.aws_iam_policy.efs_client.arn
}

# Attach SSM Full Access Policy (EFS-B)
resource "aws_iam_role_policy_attachment" "ssm_full_b" {
  role       = module.ec2_efs_b.ec2_role.name
  policy_arn = data.aws_iam_policy.ssm_full.arn
}
