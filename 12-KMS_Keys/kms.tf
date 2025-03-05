
# █▄▀ █▀▀ █▄█   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀   █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ 
# █░█ ██▄ ░█░   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░   ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ 

# KMS Key
resource "aws_kms_key" "catrobot" {
  is_enabled  = true
  description = "Allows cat rulers to communicate securely with their robot generals"

  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  key_usage                = "ENCRYPT_DECRYPT"
  multi_region             = false
}

# KMS Key Alias
resource "aws_kms_alias" "catrobot" {
  name          = "alias/catrobot"
  target_key_id = aws_kms_key.catrobot.key_id
}

# KMS Key Policy
resource "aws_kms_key_policy" "catrobot" {
  key_id = aws_kms_key.catrobot.id
  policy = templatefile("json/kms_key_policy.json", {
    aws_account_id = data.aws_caller_identity.this.account_id
    iam_admin_user = data.aws_iam_user.admin.arn
  })
}

