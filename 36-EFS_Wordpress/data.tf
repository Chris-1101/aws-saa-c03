
# █▀▄ ▄▀█ ▀█▀ ▄▀█   █▀ █▀█ █░█ █▀█ █▀▀ █▀▀ █▀ 
# █▄▀ █▀█ ░█░ █▀█   ▄█ █▄█ █▄█ █▀▄ █▄▄ ██▄ ▄█ 

# Latest Amazon Linux 2023 AMI
data "aws_ssm_parameter" "latest_al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

# Elastic File System Policy
data "aws_iam_policy" "efs_client" {
  name = "AmazonElasticFileSystemClientFullAccess"
}

# CloudWatch Agent Policy
data "aws_iam_policy" "cw_agent" {
  name = "CloudWatchAgentServerPolicy"
}

# SSM Full Access Policy
data "aws_iam_policy" "ssm_full" {
  name = "AmazonSSMFullAccess"
}

