
# █▀ █ █▀▄▀█ █▀█ █░░ █▀▀   █▀ ▀█▀ █▀█ █▀█ ▄▀█ █▀▀ █▀▀   █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ 
# ▄█ █ █░▀░█ █▀▀ █▄▄ ██▄   ▄█ ░█░ █▄█ █▀▄ █▀█ █▄█ ██▄   ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ 

# S3 bucket
resource "aws_s3_bucket" "catpics" {
  provider      = aws.prod
  bucket        = "cmb-saa-catpics-prod"
  force_destroy = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "catpics" {
  provider = aws.prod
  bucket   = aws_s3_bucket.catpics.id

  rule {
    bucket_key_enabled = true
  }
}

