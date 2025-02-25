
# █▀▀ █░░ ▄▀█ █▀ ▀█▀ █ █▀▀   █▀▀ █▀█ █▀▄▀█ █▀█ █░█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ██▄ █▄▄ █▀█ ▄█ ░█░ █ █▄▄   █▄▄ █▄█ █░▀░█ █▀▀ █▄█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# NOTE: without an IAM role granting SSM access, the ssm-agent will be unavailable

# EC2 Instance
resource "aws_instance" "saa_first_instance" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  key_name      = data.aws_key_pair.operations.key_name

  # Network
  subnet_id                   = data.aws_subnet.selected.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [ aws_security_group.saa_first_instance.id ]

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
    hostname_type = "ip-name"
    enable_resource_name_dns_a_record = true
    enable_resource_name_dns_aaaa_record = false
  }

  # Metadata Options
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
  }

  tags = {
    Name = local.name
  }

  lifecycle {
    ignore_changes = [ ami ]
  }
}

