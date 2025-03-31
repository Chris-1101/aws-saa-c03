
# █▀█ █░█ ▀█▀ █▀█ █░█ ▀█▀ █▀ 
# █▄█ █▄█ ░█░ █▀▀ █▄█ ░█░ ▄█ 

output "cloudfront_url" {
  value       = aws_cloudfront_distribution.s3_static_website.domain_name
  description = "CloudFront URL"
}

output "s3_website_url" {
  value       = aws_s3_bucket_website_configuration.static_website.website_endpoint
  description = "S3 Website URL"
}

