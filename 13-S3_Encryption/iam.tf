
# █ █▀▄ █▀▀ █▄░█ ▀█▀ █ ▀█▀ █▄█   ▄▀█ █▀▀ █▀▀ █▀▀ █▀ █▀   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀ 
# █ █▄▀ ██▄ █░▀█ ░█░ █ ░█░ ░█░   █▀█ █▄▄ █▄▄ ██▄ ▄█ ▄█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░ 
#
# NOTE: uncomment to apply, comment to remove
# # Policy Attachment
# resource "aws_iam_user_policy_attachment" "deny_kms" {
#   user       = data.aws_iam_user.admin.user_name
#   policy_arn = aws_iam_policy.deny_kms.arn
# }
#
# # Deny KMS Policy
# resource "aws_iam_policy" "deny_kms" {
#   name        = "DenyKMS"
#   description = "Denies all access to KMS"
#   policy      = file("json/deny_kms_policy.json")
# }

