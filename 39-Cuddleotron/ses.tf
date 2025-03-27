
# █▀ █ █▀▄▀█ █▀█ █░░ █▀▀   █▀▀ █▀▄▀█ ▄▀█ █ █░░   █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ 
# ▄█ █ █░▀░█ █▀▀ █▄▄ ██▄   ██▄ █░▀░█ █▀█ █ █▄▄   ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ 

# Sender Email Identity
resource "aws_sesv2_email_identity" "sender" {
  email_identity = var.sender_email
}

# Receiver Email Identity
resource "aws_sesv2_email_identity" "receiver" {
  email_identity = var.receiver_email
}

