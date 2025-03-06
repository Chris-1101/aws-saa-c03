
# █ █▀▄ █▀▀ █▄░█ ▀█▀ █ ▀█▀ █▄█   ▄▀█ █▀▀ █▀▀ █▀▀ █▀ █▀   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀ 
# █ █▄▀ ██▄ █░▀█ ░█░ █ ░█░ ░█░   █▀█ █▄▄ █▄▄ ██▄ ▄█ ▄█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░ 

# IAM User Sally
resource "aws_iam_user" "sally" {
  name = "Sally"
}

# IAM User Login Profile
resource "aws_iam_user_login_profile" "sally" {
  user                    = aws_iam_user.sally.name
  password_length         = 10
  password_reset_required = true

  lifecycle {
    ignore_changes = [ password_length ]
  }
}

# Managed Policy IAMUserChangePassword Attachement
resource "aws_iam_user_policy_attachment" "sally_password_change" {
  user       = aws_iam_user.sally.name
  policy_arn = data.aws_iam_policy.iam_user_change_password.arn
}

# S3 Admin Inlne Policy
# NOTE: Uncomment to add, comment to remove
# resource "aws_iam_user_policy" "s3_admin" {
#   name   = "s3admininline"
#   user   = aws_iam_user.sally.name
#   policy = file("json/s3_fulladmin.json")
# }

# AllowAllS3ExceptCats Policy Attachement
# NOTE: Uncomment to add, comment to remove
# resource "aws_iam_user_policy_attachment" "sally_s3_access" {
#   user       = aws_iam_user.sally.name
#   policy_arn = aws_iam_policy.s3_allow_all_except_catpics.arn
# }

# S3 Bucket Access Policy
resource "aws_iam_policy" "s3_allow_all_except_catpics" {
  name        = "AllowAllS3ExceptCats"
  description = "Allow access to all S3 buckets, except catpics"
  policy      = templatefile("json/s3_catpics_access.json", {
    catpics_arn = aws_s3_bucket.catpics.arn
  })
}
