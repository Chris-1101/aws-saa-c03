
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
  password_reset_required = false

  lifecycle {
    ignore_changes = [ password_length ]
  }
}

# IAM Group developers
resource "aws_iam_group" "developers" {
  name = "developers"
}

# Group Assignments for IAM User Sally
resource "aws_iam_user_group_membership" "sally" {
  user   = aws_iam_user.sally.name
  groups = [ aws_iam_group.developers.name ]
}

# Managed Policy IAMUserChangePassword Attachement
resource "aws_iam_user_policy_attachment" "sally_password_change" {
  user       = aws_iam_user.sally.name
  policy_arn = data.aws_iam_policy.iam_user_change_password.arn
}

# Custom S3 Bucket Access Policy
resource "aws_iam_policy" "s3_allow_all_except_catpics" {
  name        = "AllowAllS3ExceptCats"
  description = "Allow access to all S3 buckets, except catpics"
  policy      = templatefile("json/s3_catpics_access.json", {
    catpics_arn = aws_s3_bucket.catpics.arn
  })
}

# AllowAllS3ExceptCats User Policy Attachement
# NOTE: Uncomment to add, comment to remove
# resource "aws_iam_user_policy_attachment" "sally_s3_access" {
#   user       = aws_iam_user.sally.name
#   policy_arn = aws_iam_policy.s3_allow_all_except_catpics.arn
# }

# AllowAllS3ExceptCats Group Policy Attachement
# NOTE: Uncomment to add, comment to remove
# resource "aws_iam_group_policy_attachment" "developers_s3_access" {
#   group      = aws_iam_group.developers.name
#   policy_arn = aws_iam_policy.s3_allow_all_except_catpics.arn
# }

