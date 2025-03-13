
# █░█ █ █▀█ ▀█▀ █░█ ▄▀█ █░░   █▀█ █▀█ █ █░█ ▄▀█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ▀▄▀ █ █▀▄ ░█░ █▄█ █▀█ █▄▄   █▀▀ █▀▄ █ ▀▄▀ █▀█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# Security Group
resource "aws_security_group" "ecs_task" {
  name        = "${ local.task_name }-sg"
  description = "Controls access to ECS task ${ local.task_name }"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "${ local.task_name }-sg"
  }
}

# HTTP Ingress Rule
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.ecs_task.id
  description       = "Allow all inbound HTTP connections"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}

# Egress Rule
resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.ecs_task.id
  description       = "Allow all outbound connections"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

