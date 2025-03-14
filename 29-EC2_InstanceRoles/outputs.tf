
# █▀█ █░█ ▀█▀ █▀█ █░█ ▀█▀ █▀ 
# █▄█ █▄█ ░█░ █▀▀ █▄█ ░█░ ▄█ 

output "s3_bucket_name" {
  value       = aws_s3_bucket.demo.id
  description = "S3 Bucket Name"
}

output "ec2_instance_id" {
  value       = module.ec2_instance.ec2_instance.id
  description = "EC2 Instance ID"
}

output "ec2_instance_ip" {
  value       = module.ec2_instance.ec2_instance.public_ip
  description = "EC2 Instance Public IP"
}

output "ec2_instance_dns" {
  value       = module.ec2_instance.ec2_instance.public_dns
  description = "EC2 Instance Public IP"
}

