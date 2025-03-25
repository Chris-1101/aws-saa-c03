
# █▀█ █░█ ▀█▀ █▀█ █░█ ▀█▀ █▀ 
# █▄█ █▄█ ░█░ █▀▀ █▄█ ░█░ ▄█ 

output "instance_one_id" {
  value       = aws_instance.one.id
  description = "ID of the first EC2 instance"
}

output "instance_two_id" {
  value       = aws_instance.two.id
  description = "ID of the second EC2 instance"
}

