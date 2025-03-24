
# █▀▀ █░░ ▄▀█ █▀ ▀█▀ █ █▀▀   █▀▀ █▀█ █▀▄▀█ █▀█ █░█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ██▄ █▄▄ █▀█ ▄█ ░█░ █ █▄▄   █▄▄ █▄█ █░▀░█ █▀▀ █▄█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# EC2 Launch Template
resource "aws_launch_template" "this" {
  name = "web-lt"

  instance_type = "t2.micro"
  image_id      = data.aws_ssm_parameter.latest_al2023.value
  user_data     = base64encode(file("user-data.sh"))

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_web.name 
  }

  network_interfaces {
    associate_public_ip_address = true
    ipv6_address_count          = 0
    security_groups = [ aws_security_group.ec2_web.id ]
  }

  private_dns_name_options {
    hostname_type                        = "ip-name"
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
  }

  lifecycle {
    ignore_changes = [ image_id ]
  }
}

# EC2 Auto-Scaling Group
resource "aws_autoscaling_group" "this" {
  name             = "saa-web-asg"
  min_size         = 0
  max_size         = 10
  desired_capacity = 6

  # LT Version
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  # VPC Subnets
  vpc_zone_identifier = [
    module.saa_vpc_1.subnet_web_a.id,
    module.saa_vpc_1.subnet_web_b.id,
    module.saa_vpc_1.subnet_web_c.id
  ]

  # Health Check
  health_check_type         = "ELB"
  health_check_grace_period = 300
  target_group_arns         = [ aws_lb_target_group.web.arn ]

  tag {
    key                 = "Name"
    value               = "saa-cat-web"
    propagate_at_launch = true
  }
}

