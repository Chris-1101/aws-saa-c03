
# █▀ █ █▀▄▀█ █▀█ █░░ █▀▀   █▀ ▀█▀ █▀█ █▀█ ▄▀█ █▀▀ █▀▀   █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ 
# ▄█ █ █░▀░█ █▀▀ █▄▄ ██▄   ▄█ ░█░ █▄█ █▀▄ █▀█ █▄█ ██▄   ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ 

# S3 bucket
resource "aws_s3_bucket" "cloudtrail_logs" {
  bucket        = "cmb-saa-cloudtrail-logs"
  force_destroy = false
}

# Bucket Policy
resource "aws_s3_bucket_policy" "cloudtrail_logs" {
  bucket = aws_s3_bucket.cloudtrail_logs.id
  policy = templatefile("json/s3_policy.json", {
    aws_account_id      = data.aws_caller_identity.this.account_id
    aws_organisation_id = data.aws_organizations_organization.this.id
    bucket_name         = aws_s3_bucket.cloudtrail_logs.id
    trail_name          = aws_cloudtrail.org.name
  })
}

