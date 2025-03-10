
# █▀▄ ▄▀█ ▀█▀ ▄▀█   █▀ █▀█ █░█ █▀█ █▀▀ █▀▀ █▀ 
# █▄▀ █▀█ ░█░ █▀█   ▄█ █▄█ █▄█ █▀▄ █▄▄ ██▄ ▄█ 

# EC2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = [ "amazon" ]

  filter {
    name   = "name"
    values = [ "al2023-ami-2023.*-x86_64" ]
  }
}

# SSM Managed Instance Core Policy
data "aws_iam_policy" "ssm_managed_instance_core" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

