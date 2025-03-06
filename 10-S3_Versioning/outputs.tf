
# █▀█ █░█ ▀█▀ █▀█ █░█ ▀█▀ █▀ 
# █▄█ █▄█ ░█░ █▀▀ █▄█ ░█░ ▄█ 

output "s3_bucket" {
  value       = aws_s3_bucket.static_website.id
  description = "Name of the S3 bucket"
}

output "static_website_url" {
  value       = aws_s3_bucket_website_configuration.static_website.website_endpoint
  description = "Public URL of the S3 website/endpoint"
}

