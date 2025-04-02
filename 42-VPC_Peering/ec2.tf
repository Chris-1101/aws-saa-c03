
# █▀▀ █░░ ▄▀█ █▀ ▀█▀ █ █▀▀   █▀▀ █▀█ █▀▄▀█ █▀█ █░█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ██▄ █▄▄ █▀█ ▄█ ░█░ █ █▄▄   █▄▄ █▄█ █░▀░█ █▀▀ █▄█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# Private EC2 Instance VPC A
resource "aws_instance" "vpc_a" {
  ami                  = data.aws_ssm_parameter.latest_al2023.value
  instance_type        = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  # Network
  subnet_id                   = aws_subnet.a.id
  vpc_security_group_ids      = [ aws_security_group.vpc_a.id ]

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
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
  }

  # Metadata Options
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
  }

  tags = {
    Name = "saa-private-a"
  }

  lifecycle {
    ignore_changes = [ ami ]
  }
}

# Private EC2 Instance VPC B
resource "aws_instance" "vpc_b" {
  ami                  = data.aws_ssm_parameter.latest_al2023.value
  instance_type        = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  # Network
  subnet_id                   = aws_subnet.b.id
  vpc_security_group_ids      = [ aws_security_group.vpc_b.id ]

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
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
  }

  # Metadata Options
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
  }

  tags = {
    Name = "saa-private-b"
  }

  lifecycle {
    ignore_changes = [ ami ]
  }
}

# Private EC2 Instance VPC A
resource "aws_instance" "vpc_c" {
  ami                  = data.aws_ssm_parameter.latest_al2023.value
  instance_type        = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  # Network
  subnet_id                   = aws_subnet.c.id
  vpc_security_group_ids      = [ aws_security_group.vpc_c.id ]

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
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
  }

  # Metadata Options
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
  }

  tags = {
    Name = "saa-private-c"
  }

  lifecycle {
    ignore_changes = [ ami ]
  }
}

