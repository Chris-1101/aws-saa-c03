
# █▀ █ █▀▄▀█ █▀█ █░░ █▀▀   █▀ ▀█▀ █▀█ █▀█ ▄▀█ █▀▀ █▀▀   █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ 
# ▄█ █ █░▀░█ █▀▀ █▄▄ ██▄   ▄█ ░█░ █▄█ █▀▄ █▀█ █▄█ ██▄   ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ 

# Catpics Bucket
resource "aws_s3_bucket" "catpics" {
  bucket        = "cmb-saa-catpics"
  force_destroy = true
}

# Animalpics Bucket
resource "aws_s3_bucket" "animalpics" {
  bucket        = "cmb-saa-animalpics"
  force_destroy = true
}

