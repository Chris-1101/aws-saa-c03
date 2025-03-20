
# █▀█ █░█ ▀█▀ █▀█ █░█ ▀█▀ █▀ 
# █▄█ █▄█ ░█░ █▀▀ █▄█ ░█░ ▄█ 

output "efs_a_instance_id" {
  value       = module.ec2_efs_a.ec2_instance.id
  description = "EFS-A Instance ID"
}

output "efs_b_instance_id" {
  value       = module.ec2_efs_b.ec2_instance.id
  description = "EFS-B Instance ID"
}

output "efs_id" {
  value       = aws_efs_file_system.this.id
  description = "EFS Filesystem ID"
}

