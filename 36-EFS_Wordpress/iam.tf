
# █ █▀▄ █▀▀ █▄░█ ▀█▀ █ ▀█▀ █▄█   ▄▀█ █▀▀ █▀▀ █▀▀ █▀ █▀   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀ 
# █ █▄▀ ██▄ █░▀█ ░█░ █ ░█░ ░█░   █▀█ █▄▄ █▄▄ ██▄ ▄█ ▄█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░ 

# Attach Elastic File System Policy (Wordpress 1)
resource "aws_iam_role_policy_attachment" "efs_client_1" {
  role       = module.ec2_wordpress_1.ec2_role.name
  policy_arn = data.aws_iam_policy.efs_client.arn
}

# Attach CW Agent Policy (Wordpress 1)
resource "aws_iam_role_policy_attachment" "cw_agent_1" {
  role       = module.ec2_wordpress_1.ec2_role.name
  policy_arn = data.aws_iam_policy.cw_agent.arn
}

# Attach SSM Full Access Policy (Wordpress 1)
resource "aws_iam_role_policy_attachment" "ssm_full_1" {
  role       = module.ec2_wordpress_1.ec2_role.name
  policy_arn = data.aws_iam_policy.ssm_full.arn
}

# Attach Elastic File System Policy (Wordpress 2)
resource "aws_iam_role_policy_attachment" "efs_client_2" {
  role       = module.ec2_wordpress_2.ec2_role.name
  policy_arn = data.aws_iam_policy.efs_client.arn
}

# Attach CW Agent Policy (Wordpress 2)
resource "aws_iam_role_policy_attachment" "cw_agent_2" {
  role       = module.ec2_wordpress_2.ec2_role.name
  policy_arn = data.aws_iam_policy.cw_agent.arn
}

# Attach SSM Full Access Policy (Wordpress 2)
resource "aws_iam_role_policy_attachment" "ssm_full_2" {
  role       = module.ec2_wordpress_2.ec2_role.name
  policy_arn = data.aws_iam_policy.ssm_full.arn
}

