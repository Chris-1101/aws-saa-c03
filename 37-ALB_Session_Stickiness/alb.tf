
# █░░ █▀█ ▄▀█ █▀▄   █▄▄ ▄▀█ █░░ ▄▀█ █▄░█ █▀▀ █▀▀ █▀█ 
# █▄▄ █▄█ █▀█ █▄▀   █▄█ █▀█ █▄▄ █▀█ █░▀█ █▄▄ ██▄ █▀▄ 

# Application Load Balancer
resource "aws_lb" "application" {
  name               = "saa-alb"
  load_balancer_type = "application"
  internal           = false
  ip_address_type    = "ipv4"
  security_groups    = [ aws_security_group.alb.id ]

  # Network
  subnets = [
    module.saa_vpc_1.subnet_web_a.id,
    module.saa_vpc_1.subnet_web_b.id,
    module.saa_vpc_1.subnet_web_c.id
  ]
}

# Port 80 Listener
resource "aws_lb_listener" "http_80" {
  load_balancer_arn = aws_lb.application.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

# Target Group
resource "aws_lb_target_group" "web" {
  name     = "saa-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id = module.saa_vpc_1.vpc.id

  # Health Check
  health_check {
    path                = "/index.php"
    interval            = 30
    timeout             = 5
    unhealthy_threshold = 5
  }
  
  # Session Stickiness
  stickiness {
    enabled         = false
    type            = "lb_cookie"
    cookie_duration = 60
  }
}

