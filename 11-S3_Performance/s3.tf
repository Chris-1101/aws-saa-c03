
# █▀ █ █▀▄▀█ █▀█ █░░ █▀▀   █▀ ▀█▀ █▀█ █▀█ ▄▀█ █▀▀ █▀▀   █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ 
# ▄█ █ █░▀░█ █▀▀ █▄▄ ██▄   ▄█ ░█░ █▄█ █▀▄ █▀█ █▄█ ██▄   ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ 

# S3 bucket
resource "aws_s3_bucket" "perf_demo" {
  bucket        = "cmb-saa-performance-demo"
  force_destroy = true
}

# Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "perf_demo" {
  bucket = aws_s3_bucket.perf_demo.id

  rule {
    bucket_key_enabled = true

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Transfer Acceleration
resource "aws_s3_bucket_accelerate_configuration" "perf_demo" {
  bucket = aws_s3_bucket.perf_demo.id
  status = "Enabled"
}

