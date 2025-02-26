
# █▀ █ █▀▄▀█ █▀█ █░░ █▀▀   █▀ ▀█▀ █▀█ █▀█ ▄▀█ █▀▀ █▀▀   █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ 
# ▄█ █ █░▀░█ █▀▀ █▄▄ ██▄   ▄█ ░█░ █▄█ █▀▄ █▀█ █▄█ ██▄   ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ 

# S3 bucket
resource "aws_s3_bucket" "koala_campaign" {
  bucket = "cmb-saa-koala-campaign"
}

# Disable public access block
resource "aws_s3_bucket_public_access_block" "allow_public_access" {
  bucket = aws_s3_bucket.koala_campaign.id

  block_public_acls = false
  ignore_public_acls = false
  block_public_policy = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.koala_campaign.id

  rule {
    bucket_key_enabled = true
  }
}

