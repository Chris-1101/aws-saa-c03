
# █▄▀ █▀▀ █▄█   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀   █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ 
# █░█ ██▄ ░█░   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░   ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ 

# KMS Key
resource "aws_kms_key" "catpics" {
  is_enabled  = true

  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  key_usage                = "ENCRYPT_DECRYPT"
  multi_region             = false
}

# KMS Key Alias
resource "aws_kms_alias" "catpics" {
  name          = "alias/catpics"
  target_key_id = aws_kms_key.catpics.key_id
}

# KMS Key Policy
resource "aws_kms_key_policy" "catpics" {
  key_id = aws_kms_key.catpics.id
  policy = templatefile("json/kms_key_policy.json", {
    aws_account_id = data.aws_caller_identity.this.account_id
  })
}

