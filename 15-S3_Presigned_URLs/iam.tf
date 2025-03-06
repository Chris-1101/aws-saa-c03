
# █ █▀▄ █▀▀ █▄░█ ▀█▀ █ ▀█▀ █▄█   ▄▀█ █▀▀ █▀▀ █▀▀ █▀ █▀   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀ 
# █ █▄▀ ██▄ █░▀█ ░█░ █ ░█░ ░█░   █▀█ █▄▄ █▄▄ ██▄ ▄█ ▄█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░ 
#
# NOTE: uncomment to apply, comment to remove
# Policy Attachment
# resource "aws_iam_user_policy_attachment" "deny_s3" {
#   user = data.aws_iam_user.admin.user_name
#   policy_arn = aws_iam_policy.deny_s3.arn
# }
#
# # Deny KMS Policy
# resource "aws_iam_policy" "deny_s3" {
#   name        = "DenyS3"
#   description = "Denies all access to S3"
#   policy      = file("json/deny_s3.json")
# }

