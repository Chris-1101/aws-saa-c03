
# █▀█ █░█ ▀█▀ █▀█ █░█ ▀█▀ █▀ 
# █▄█ █▄█ ░█░ █▀▀ █▄█ ░█░ ▄█ 

output "bucket" {
  value = aws_s3_bucket.this
  description = "The S3 bucket"
}

output "versioning" {
  value = aws_s3_bucket_versioning.this
  description = "The S3 bucket's versioning configuration"
}

output "web" {
  value = aws_s3_bucket_website_configuration.this
  description = "The S3 bucket"
}

