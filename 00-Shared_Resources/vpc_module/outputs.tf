
# █▀█ █░█ ▀█▀ █▀█ █░█ ▀█▀ █▀ 
# █▄█ █▄█ ░█░ █▀▀ █▄█ ░█░ ▄█ 

output "vpc" {
  value       = aws_vpc.this
  description = "The module's VPC"
}

output "igw" {
  value       = aws_internet_gateway.this
  description = "The VPC's IGW"
}

output "subnet_reserved_a" {
  value       = aws_subnet.reserved_a
  description = "Reserved Subnet A"
}

output "subnet_reserved_b" {
  value       = aws_subnet.reserved_b
  description = "Reserved Subnet B"
}

output "subnet_reserved_c" {
  value       = aws_subnet.reserved_c
  description = "Reserved Subnet C"
}

output "subnet_db_a" {
  value       = aws_subnet.db_a
  description = "Database Subnet A"
}

output "subnet_db_b" {
  value       = aws_subnet.db_b
  description = "Database Subnet B"
}

output "subnet_db_c" {
  value       = aws_subnet.db_c
  description = "Database Subnet C"
}

output "subnet_app_a" {
  value       = aws_subnet.app_a
  description = "Application Subnet A"
}

output "subnet_app_b" {
  value       = aws_subnet.app_b
  description = "Application Subnet B"
}

output "subnet_app_c" {
  value       = aws_subnet.app_c
  description = "Application Subnet C"
}

output "subnet_web_a" {
  value       = aws_subnet.web_a
  description = "Web Subnet A"
}

output "subnet_web_b" {
  value       = aws_subnet.web_b
  description = "Web Subnet B"
}

output "subnet_web_c" {
  value       = aws_subnet.web_c
  description = "Web Subnet C"
}

