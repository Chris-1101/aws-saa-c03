
# █▀█ █░█ ▀█▀ █▀█ █░█ ▀█▀ █▀ 
# █▄█ █▄█ ░█░ █▀▀ █▄█ ░█░ ▄█ 

output "s3_bucket" {
  value = aws_s3_bucket.catpics.id
  description = "Name of the S3 bucket"
}

output "kms_key_alias" {
  value = aws_kms_alias.catpics.arn
  description = "Key Alias ARN"
}

output "kms_key_id" {
  value = aws_kms_key.catpics.key_id
  description = "KMS Key ID"
}

