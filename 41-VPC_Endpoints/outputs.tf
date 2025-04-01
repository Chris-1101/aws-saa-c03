
# █▀█ █░█ ▀█▀ █▀█ █░█ ▀█▀ █▀ 
# █▄█ █▄█ ░█░ █▀▀ █▄█ ░█░ ▄█ 

output "ec2_instance_id" {
  value       = aws_instance.this.id
  description = "EC2 Instance ID"
}

output "ec2_instance_connect_endpoint" {
  value       = aws_ec2_instance_connect_endpoint.this.dns_name
  description = "EC2 Instance Connect Interface Endpoint DNS"
}

