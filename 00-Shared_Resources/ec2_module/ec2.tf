
# █▀▀ █░░ ▄▀█ █▀ ▀█▀ █ █▀▀   █▀▀ █▀█ █▀▄▀█ █▀█ █░█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ██▄ █▄▄ █▀█ ▄█ ░█░ █ █▄▄   █▄▄ █▄█ █░▀░█ █▀▀ █▄█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# EC2 Instance
resource "aws_instance" "this" {
  ami                  = data.aws_ami.amazon_linux.id
  instance_type        = var.ec2_instance_type
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  key_name             = var.ec2_key_name

  # Network
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.auto_assign_ipv4           # Auto-assign public IP
  vpc_security_group_ids      = [ aws_security_group.ec2.id ]

  # Root EBS Volume
  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    delete_on_termination = true
  }

  # CPU Credits
  credit_specification {
    cpu_credits = "standard"
  }

  # Private DNS
  private_dns_name_options {
    hostname_type                        = "ip-name"
    enable_resource_name_dns_a_record    = ! var.auto_assign_ipv4
    enable_resource_name_dns_aaaa_record = false
  }

  # Metadata Options
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
  }

  tags = {
    Name = var.ec2_name
  }

  lifecycle {
    ignore_changes = [ ami ]
  }
}

