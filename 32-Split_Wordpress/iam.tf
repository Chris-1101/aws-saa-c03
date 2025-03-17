
# █ █▀▄ █▀▀ █▄░█ ▀█▀ █ ▀█▀ █▄█   ▄▀█ █▀▀ █▀▀ █▀▀ █▀ █▀   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀ 
# █ █▄▀ ██▄ █░▀█ ░█░ █ ░█░ ░█░   █▀█ █▄▄ █▄▄ ██▄ ▄█ ▄█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░ 

# Attach CloudWatch Agent Policy
resource "aws_iam_role_policy_attachment" "cw_agent" {
  role       = module.ec2_wordpress.ec2_role.name
  policy_arn = data.aws_iam_policy.cw_agent.arn
}

# Attach SSM Full Access Policy
resource "aws_iam_role_policy_attachment" "ssm_full" {
  role       = module.ec2_wordpress.ec2_role.name
  policy_arn = data.aws_iam_policy.ssm_full.arn
}

