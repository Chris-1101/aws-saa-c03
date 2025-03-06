
# █ █▀▄ █▀▀ █▄░█ ▀█▀ █ ▀█▀ █▄█   ▄▀█ █▀▀ █▀▀ █▀▀ █▀ █▀   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀ 
# █ █▄▀ ██▄ █░▀█ ░█░ █ ░█░ ░█░   █▀█ █▄▄ █▄▄ ██▄ ▄█ ▄█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░ 

# ------- North Virginia -------

# Cross-Region Replication Role
resource "aws_iam_role" "crr_east_to_west" {
  name        = "S3CrossRegionReplication_cmb-saa-mrap-east"
  description = "Cross-region replication role for bucket cmb-saa-mrap-east"
  path        = "/service-role/"

  # Trust Policy
  assume_role_policy = file("json/trust_policy.json")
}

# Policy Attachment
resource "aws_iam_role_policy_attachment" "crr_east_to_west" {
  role       = aws_iam_role.crr_east_to_west.name
  policy_arn = aws_iam_policy.crr_east_to_west.arn
}

# Cross-Region Replication Policy
resource "aws_iam_policy" "crr_east_to_west" {
  name        = "S3-CRR-cmb-saa-mrap-east"
  description = "Cross-region replication role for bucket cmb-saa-mrap-east"
  path        = "/service-role/"

  policy = templatefile("json/crr_policy.json", {
    src_bucket_name  = aws_s3_bucket.mrap_east.id
    dest_bucket_name = aws_s3_bucket.mrap_west.id
  })
}

# ------- North California -------

# Cross-Region Replication Role
resource "aws_iam_role" "crr_west_to_east" {
  name        = "S3CrossRegionReplication_cmb-saa-mrap-west"
  description = "Cross-region replication role for bucket cmb-saa-mrap-west"
  path        = "/service-role/"

  # Trust Policy
  assume_role_policy = file("json/trust_policy.json")
}

# Policy Attachment
resource "aws_iam_role_policy_attachment" "crr_west_to_east" {
  role       = aws_iam_role.crr_west_to_east.name
  policy_arn = aws_iam_policy.crr_west_to_east.arn
}

# Cross-Region Replication Policy
resource "aws_iam_policy" "crr_west_to_east" {
  name        = "S3-CRR-cmb-saa-mrap-west"
  description = "Cross-region replication role for bucket cmb-saa-mrap-west"
  path        = "/service-role/"

  policy = templatefile("json/crr_policy.json", {
    src_bucket_name  = aws_s3_bucket.mrap_west.id
    dest_bucket_name = aws_s3_bucket.mrap_east.id
  })
}

