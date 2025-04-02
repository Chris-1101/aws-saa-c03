
# █▀█ █░█ ▀█▀ █▀█ █░█ ▀█▀ █▀ 
# █▄█ █▄█ ░█░ █▀▀ █▄█ ░█░ ▄█ 

output "vpc_a_ec2_instance_id" {
  value       = aws_instance.vpc_a.id
  description = "VPC A EC2 Instance ID"
}

output "vpc_b_ec2_instance_id" {
  value       = aws_instance.vpc_b.id
  description = "VPC B EC2 Instance ID"
}

output "vpc_c_ec2_instance_id" {
  value       = aws_instance.vpc_c.id
  description = "VPC C EC2 Instance ID"
}

output "vpc_a_ec2_instance_private_ip" {
  value       = aws_instance.vpc_a.private_ip
  description = "VPC A EC2 Instance Private IP"
}

output "vpc_b_ec2_instance_private_ip" {
  value       = aws_instance.vpc_b.private_ip
  description = "VPC B EC2 Instance Private IP"
}

output "vpc_c_ec2_instance_private_ip" {
  value       = aws_instance.vpc_c.private_ip
  description = "VPC C EC2 Instance Private IP"
}

