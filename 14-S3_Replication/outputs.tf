
# █▀█ █░█ ▀█▀ █▀█ █░█ ▀█▀ █▀ 
# █▄█ █▄█ ░█░ █▀▀ █▄█ ░█░ ▄█ 

# Source Bucket
output "s3_source_bucket" {
  value = module.s3_source.bucket.id
  description = "Name of the source S3 bucket"
}

# Destination Bucket
output "s3_destination_bucket" {
  value = module.s3_destination.bucket.id
  description = "Name of the destination S3 bucket"
}

# Source Bucket Website URL
output "source_bucket_web_url" {
  value = module.s3_source.web.website_endpoint
  description = "Public URL of the source S3 website/endpoint"
}

# Destination Bucket Website URL
output "destination_bucket_web_url" {
  value = module.s3_destination.web.website_endpoint
  description = "Public URL of the destination S3 website/endpoint"
}

