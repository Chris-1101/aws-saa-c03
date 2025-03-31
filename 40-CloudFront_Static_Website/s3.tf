
# █▀ █ █▀▄▀█ █▀█ █░░ █▀▀   █▀ ▀█▀ █▀█ █▀█ ▄▀█ █▀▀ █▀▀   █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ 
# ▄█ █ █░▀░█ █▀▀ █▄▄ ██▄   ▄█ ░█░ █▄█ █▀▄ █▀█ █▄█ ██▄   ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ 

# S3 bucket
resource "aws_s3_bucket" "static_website" {
  bucket        = "cmb-saa-top10cats"
  force_destroy = true
}

# Disable public access block
# NOTE: Only for step 1: public origin
resource "aws_s3_bucket_public_access_block" "static_website" {
  bucket = aws_s3_bucket.static_website.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

# Enable public access block
# NOTE: Only for step 2: private origin
# resource "aws_s3_bucket_public_access_block" "static_website" {
#   bucket = aws_s3_bucket.static_website.id
#
#   block_public_acls       = true
#   ignore_public_acls      = true
#   block_public_policy     = true
#   restrict_public_buckets = true
# }

# Default Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "static_website" {
  bucket = aws_s3_bucket.static_website.id

  rule {
    bucket_key_enabled = true

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# S3 Static Website
resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.static_website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Bucket policy
# NOTE: Only for step 1: public origin
resource "aws_s3_bucket_policy" "static_website" {
  bucket = aws_s3_bucket.static_website.id
  policy = templatefile("json/bucket-policy.json", {
    bucket_arn = aws_s3_bucket.static_website.arn
  })
}

# Bucket policy
# NOTE: Only for step 2: private origin
# resource "aws_s3_bucket_policy" "static_website" {
#   bucket = aws_s3_bucket.static_website.id
#   policy = templatefile("json/bucket-oac-policy.json", {
#     s3_bucket_arn = aws_s3_bucket.static_website.arn
#     cf_distro_arn = aws_cloudfront_distribution.s3_static_website.arn
#   })
# }

