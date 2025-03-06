
# █▀█ █░█ ▀█▀ █▀█ █░█ ▀█▀ █▀ 
# █▄█ █▄█ ░█░ █▀▀ █▄█ ░█░ ▄█ 

output "s3_bucket" {
  value       = aws_s3_bucket.perf_demo.id
  description = "Name of the S3 bucket"
}

output "accelerated_endpoint" {
  value       = "${ aws_s3_bucket.perf_demo.id }.s3-accelerate.amazonaws.com"
  description = "Bucket endpoint for accelerated transfers"
}

