
# █ █▀▄ █▀▀ █▄░█ ▀█▀ █ ▀█▀ █▄█   ▄▀█ █▀▀ █▀▀ █▀▀ █▀ █▀   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀ 
# █ █▄▀ ██▄ █░▀█ ░█░ █ ░█░ ░█░   █▀█ █▄▄ █▄▄ ██▄ ▄█ ▄█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░ 

# Cross-Region Replication Role
resource "aws_iam_role" "crr_replication" {
  name        = "S3CrossRegionReplication_cmb-saa-src-web"
  description = "Cross-region replication role for bucket cmb-saa-src-web"
  path        = "/service-role/"

  # Trust Policy
  assume_role_policy = file("json/trust_policy.json")
}

# Policy Attachment
resource "aws_iam_role_policy_attachment" "crr_replication" {
  role = aws_iam_role.crr_replication.name
  policy_arn = aws_iam_policy.crr_replication.arn
}

# Cross-Region Replication Policy
resource "aws_iam_policy" "crr_replication" {
  name        = "S3-CRR-cmb-saa-src-web"
  description = "Cross-region replication role for bucket cmb-saa-src-web"
  path        = "/service-role/"

  policy = templatefile("json/crr_policy.json", {
    src_bucket_name = module.s3_source.bucket.id
    dest_bucket_name = module.s3_destination.bucket.id
  })
}

