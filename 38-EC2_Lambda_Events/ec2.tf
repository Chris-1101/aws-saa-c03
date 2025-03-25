
# █▀▀ █░░ ▄▀█ █▀ ▀█▀ █ █▀▀   █▀▀ █▀█ █▀▄▀█ █▀█ █░█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ██▄ █▄▄ █▀█ ▄█ ░█░ █ █▄▄   █▄▄ █▄█ █░▀░█ █▀▀ █▄█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# EC2 Instance One
resource "aws_instance" "one" {
  ami                  = data.aws_ssm_parameter.latest_al2023.value
  instance_type        = "t2.micro"

  tags = {
    Name = "saa-instance-one"
  }

  lifecycle {
    ignore_changes = [ ami ]
  }
}

# EC2 Instance Two
resource "aws_instance" "two" {
  ami                  = data.aws_ssm_parameter.latest_al2023.value
  instance_type        = "t2.micro"

  tags = {
    Name = "saa-instance-two"
  }

  lifecycle {
    ignore_changes = [ ami ]
  }
}

