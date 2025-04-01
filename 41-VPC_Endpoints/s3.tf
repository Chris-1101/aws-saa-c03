
# █▀ █ █▀▄▀█ █▀█ █░░ █▀▀   █▀ ▀█▀ █▀█ █▀█ ▄▀█ █▀▀ █▀▀   █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ 
# ▄█ █ █░▀░█ █▀▀ █▄▄ ██▄   ▄█ ░█░ █▄█ █▀▄ █▀█ █▄█ ██▄   ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ 

# S3 bucket
resource "aws_s3_bucket" "secret" {
  bucket        = "cmb-saa-secret"
  force_destroy = true
}

# Enable public access block
resource "aws_s3_bucket_public_access_block" "secret" {
  bucket = aws_s3_bucket.secret.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

# Default Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "secret" {
  bucket = aws_s3_bucket.secret.id

  rule {
    bucket_key_enabled = true

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Bucket policy
# resource "aws_s3_bucket_policy" "secret" {
#   bucket = aws_s3_bucket.secret.id
#   policy = templatefile("json/bucket-policy.json", {
#     bucket_arn = aws_s3_bucket.secret.arn
#   })
# }

# Secret Object
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.secret.id
  key    = "supersecret.txt"
  source = "data/supersecret.txt"
  etag   = filemd5("data/supersecret.txt")

  force_destroy = true
}

