
# █▀█ █░█ ▀█▀ █▀█ █░█ ▀█▀ █▀ 
# █▄█ █▄█ ░█░ █▀▀ █▄█ ░█░ ▄█ 

output "wordpress_1_id" {
  value       = module.ec2_wordpress_1.ec2_instance.id
  description = "Wordpress 1 Instance ID"
}

output "wordpress_1_ip" {
  value       = module.ec2_wordpress_1.ec2_instance.public_ip
  description = "Wordpress 1 Instance Public IP"
}

output "wordpress_2_id" {
  value       = module.ec2_wordpress_2.ec2_instance.id
  description = "Wordpress 2 Instance ID"
}

output "wordpress_2_ip" {
  value       = module.ec2_wordpress_2.ec2_instance.public_ip
  description = "Wordpress 2 Instance Public IP"
}

output "efs_id" {
  value       = aws_efs_file_system.this.id
  description = "EFS Filesystem ID"
}

output "efs_mp_a_ip" {
  value       = aws_efs_mount_target.app_a.ip_address
  description = "IP address of EFS mount target in AZ us-east-1a"
}

output "efs_mp_b_ip" {
  value       = aws_efs_mount_target.app_b.ip_address
  description = "IP address of EFS mount target in AZ us-east-1b"
}

output "efs_mp_c_ip" {
  value       = aws_efs_mount_target.app_c.ip_address
  description = "IP address of EFS mount target in AZ us-east-1c"
}

output "rds_endpoint" {
  value       = aws_db_instance.a4l_wordpress.endpoint
  description = "Endpoint of the RDS instance"
}

output "rds_az" {
  value       = aws_db_instance.a4l_wordpress.availability_zone
  description = "Availability zone of the RDS instance"
}

