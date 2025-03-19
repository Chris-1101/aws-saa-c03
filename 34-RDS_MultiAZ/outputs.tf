
# █▀█ █░█ ▀█▀ █▀█ █░█ ▀█▀ █▀ 
# █▄█ █▄█ ░█░ █▀▀ █▄█ ░█░ ▄█ 

output "ec2_instance_id" {
  value       = module.ec2_wordpress.ec2_instance.id
  description = "EC2 Instance ID"
}

output "ec2_instance_public_ip" {
  value       = module.ec2_wordpress.ec2_instance.public_ip
  description = "EC2 Instance Public IP"
}

output "rds_endpoint" {
  value       = aws_db_instance.a4l_wordpress.endpoint
  description = "Endpoint of the RDS instance"
}

output "rds_az" {
  value       = aws_db_instance.a4l_wordpress.availability_zone
  description = "Availability zone of the RDS instance"
}

