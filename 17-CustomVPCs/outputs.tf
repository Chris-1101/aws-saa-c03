
# █▀█ █░█ ▀█▀ █▀█ █░█ ▀█▀ █▀ 
# █▄█ █▄█ ░█░ █▀▀ █▄█ ░█░ ▄█ 

output "vpc_id" {
  value       = aws_vpc.this.id
  description = "VPC ID"
}

output "vpc_ipv4_cidr" {
  value       = aws_vpc.this.cidr_block
  description = "IPv4 CIDR Block"
}

output "vpc_ipv6_cidr" {
  value       = aws_vpc.this.ipv6_cidr_block
  description = "IPv6 CIDR Block"
}

