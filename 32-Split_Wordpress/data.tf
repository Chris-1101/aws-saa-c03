
# █▀▄ ▄▀█ ▀█▀ ▄▀█   █▀ █▀█ █░█ █▀█ █▀▀ █▀▀ █▀ 
# █▄▀ █▀█ ░█░ █▀█   ▄█ █▄█ █▄█ █▀▄ █▄▄ ██▄ ▄█ 

# CloudWatch Agent Policy
data "aws_iam_policy" "cw_agent" {
  name = "CloudWatchAgentServerPolicy"
}

# SSM Full Access Policy
data "aws_iam_policy" "ssm_full" {
  name = "AmazonSSMFullAccess"
}

