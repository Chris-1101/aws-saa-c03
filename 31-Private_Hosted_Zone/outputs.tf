
# █▀█ █░█ ▀█▀ █▀█ █░█ ▀█▀ █▀ 
# █▄█ █▄█ ░█░ █▀▀ █▄█ ░█░ ▄█ 

output "ec2_instance_id" {
  value       = module.ec2_instance.ec2_instance.id
  description = "EC2 Instance ID"
}

