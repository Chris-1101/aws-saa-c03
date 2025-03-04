
# █▀█ █░█ ▀█▀ █▀█ █░█ ▀█▀ █▀ 
# █▄█ █▄█ ░█░ █▀▀ █▄█ ░█░ ▄█ 

# IAM Username
output "iam_user" {
  value       = aws_iam_user.sally.name
  description = "IAM Username"
}

# IAM Password
output "iam_password" {
  # NOTE: not great, only doing this to mirror the cloudformation template
  value       = nonsensitive(aws_iam_user_login_profile.sally.password)
  description = "IAM Password"
}

# Catpics Bucket
output "s3_bucket_catpics" {
  value       = aws_s3_bucket.catpics.id
  description = "Bucketname for catpictures (the best animal!)"
}

# Animalpics Bucket
output "s3_bucket_animalpics" {
  value       = aws_s3_bucket.catpics.id
  description = "Bucketname for animalpics (the almost best animals!)"
}

