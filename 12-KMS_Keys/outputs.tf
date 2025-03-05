
# █▀█ █░█ ▀█▀ █▀█ █░█ ▀█▀ █▀ 
# █▄█ █▄█ ░█░ █▀▀ █▄█ ░█░ ▄█ 

output "kms_key_alias" {
  value = aws_kms_alias.catrobot.arn
  description = "Key Alias ARN"
}

output "kms_key_id" {
  value = aws_kms_key.catrobot.key_id
  description = "KMS Key ID"
}

