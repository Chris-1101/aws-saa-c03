
# █▀█ █░█ ▀█▀ █▀█ █░█ ▀█▀ █▀ 
# █▄█ █▄█ ░█░ █▀▀ █▄█ ░█░ ▄█ 

# EC2 Instance ID
output "instance_id" {
  value       = aws_instance.this.id
  description = "ID of the newly created EC2 instance"
}

# EC2 Instance Availability Zone
output "availability_zone" {
  value       = aws_instance.this.availability_zone
  description = "Availability Zone of the newly created EC2 instance"
}

# EC2 Instance Public DNS
output "public_dns" {
  value       = aws_instance.this.public_dns
  description = "Public DNSName of the newly created EC2 instance"
}

# EC2 Instance Public IP
output "public_ip" {
  value       = aws_instance.this.public_ip
  description = "Public IP address of the newly created EC2 instance"
}

