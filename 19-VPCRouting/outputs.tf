
# █▀█ █░█ ▀█▀ █▀█ █░█ ▀█▀ █▀ 
# █▄█ █▄█ ░█░ █▀▀ █▄█ ░█░ ▄█ 

# Internet Gateway ID
output "internet_gateway_id" {
  value       = aws_internet_gateway.this.id
  description = "Internet Gateway ID"
}

# Route Table ID
output "route_table_id" {
  value       = aws_route_table.this.id
  description = "Route Table ID"
}

# EC2 Instance ID
output "ec2_instance_id" {
  value       = aws_instance.this.id
  description = "EC2 Instance ID"
}

# EC2 Instance DNS
output "ec2_dns_hostname" {
  value       = aws_instance.this.public_dns
  description = "EC2 DNS Hostname"
}

# EC2 Instance IPv4 Address
output "ec2_ipv4" {
  value       = aws_instance.this.public_ip
  description = "EC2 Public IP"
}

# EC2 Instance IPv6 Addresses
output "ec2_ipv6" {
  value       = aws_instance.this.ipv6_addresses
  description = "EC2 IPv6 Addresses"
}

