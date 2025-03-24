
# █▀█ █░█ ▀█▀ █▀█ █░█ ▀█▀ █▀ 
# █▄█ █▄█ ░█░ █▀▀ █▄█ ░█░ ▄█ 

output "alb_dns" {
  value       = aws_lb.application.dns_name
  description = "DNS of the Application ELB"
}

