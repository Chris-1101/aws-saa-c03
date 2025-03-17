
# █▀█ █░█ ▀█▀ █▀█ █░█ ▀█▀ █▀ 
# █▄█ █▄█ ░█░ █▀▀ █▄█ ░█░ ▄█ 

output "web_instance_id" {
  value       = module.ec2_wordpress.ec2_instance.id
  description = "Web Instance ID"
}

output "web_instance_public_ip" {
  value       = module.ec2_wordpress.ec2_instance.public_ip
  description = "Web Instance Public IP"
}

output "db_instance_id" {
  value       = module.ec2_mariadb.ec2_instance.id
  description = "DB Instance ID"
}

output "db_instance_private_ip" {
  value       = module.ec2_mariadb.ec2_instance.private_ip
  description = "DB Instance Private IP"
}

