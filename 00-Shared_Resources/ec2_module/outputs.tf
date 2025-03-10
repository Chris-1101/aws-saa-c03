
# █▀█ █░█ ▀█▀ █▀█ █░█ ▀█▀ █▀ 
# █▄█ █▄█ ░█░ █▀▀ █▄█ ░█░ ▄█ 

# EC2 Instance
output "ec2_instance" {
  value       = aws_instance.this
  description = "EC2 Instance"
}

# EC2 Security Group
output "ec2_sg" {
  value       = aws_security_group.ec2
  description = "EC2 Security Group"
}

