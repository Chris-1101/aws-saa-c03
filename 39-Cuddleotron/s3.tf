
# █▀ █ █▀▄▀█ █▀█ █░░ █▀▀   █▀ ▀█▀ █▀█ █▀█ ▄▀█ █▀▀ █▀▀   █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ 
# ▄█ █ █░▀░█ █▀▀ █▄▄ ██▄   ▄█ ░█░ █▄█ █▀▄ █▀█ █▄█ ██▄   ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ 

# S3 bucket
resource "aws_s3_bucket" "cuddleotron_frontend" {
  bucket        = "cmb-saa-cuddleotron"
  force_destroy = true
}

# Disable public access block
resource "aws_s3_bucket_public_access_block" "cuddleotron_frontend" {
  bucket = aws_s3_bucket.cuddleotron_frontend.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

# Default Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "cuddleotron_frontend" {
  bucket = aws_s3_bucket.cuddleotron_frontend.id

  rule {
    bucket_key_enabled = true

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# S3 Static Website
resource "aws_s3_bucket_website_configuration" "cuddleotron_frontend" {
  bucket = aws_s3_bucket.cuddleotron_frontend.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

# Bucket Policy
resource "aws_s3_bucket_policy" "cuddleotron_frontend" {
  bucket = aws_s3_bucket.cuddleotron_frontend.id
  policy = templatefile("json/bucket_policy.json", {
    bucket_arn = aws_s3_bucket.cuddleotron_frontend.arn
  })
}

# ---

# NOTE: Terraforming objects isn't scalable and would rarely be found in production,
#  but in this case it makes it easy to sub in the backend API Gateway endpoint

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.cuddleotron_frontend.id
  key    = "index.html"
  source = "data/index.html"
  etag   = filemd5("data/index.html")

  force_destroy = true
}

resource "aws_s3_object" "main_css" {
  bucket = aws_s3_bucket.cuddleotron_frontend.id
  key    = "main.css"
  source = "data/main.css"
  etag   = filemd5("data/main.css")

  force_destroy = true
}

resource "aws_s3_object" "serverless_js" {
  bucket  = aws_s3_bucket.cuddleotron_frontend.id
  key     = "serverless.js"
  content = templatefile("data/serverless.js", {
    api_url = aws_api_gateway_stage.prod.invoke_url
    api_endpoint = aws_api_gateway_resource.petcuddleotron.path
  })

  force_destroy = true
}

resource "aws_s3_object" "whiskers_png" {
  bucket = aws_s3_bucket.cuddleotron_frontend.id
  key    = "whiskers.png"
  source = "data/whiskers.png"
  etag   = filemd5("data/whiskers.png")

  force_destroy = true
}

