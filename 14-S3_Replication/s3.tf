
# █▀ █ █▀▄▀█ █▀█ █░░ █▀▀   █▀ ▀█▀ █▀█ █▀█ ▄▀█ █▀▀ █▀▀   █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ 
# ▄█ █ █░▀░█ █▀▀ █▄▄ ██▄   ▄█ ░█░ █▄█ █▀▄ █▀█ █▄█ ██▄   ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ 

# Source Bucket
module "s3_source" {
  source      = "./s3_module"
  bucket_name = "cmb-saa-src-web"
}

# Destination Bucket
module "s3_destination" {
  source      = "./s3_module"
  bucket_name = "cmb-saa-dest-web"

  providers = {
    aws = aws.ncali
  }
}

# Cross-Region Replication
resource "aws_s3_bucket_replication_configuration" "dr" {
  bucket = module.s3_source.bucket.id
  role   = aws_iam_role.crr_replication.arn

  depends_on = [ module.s3_source.versioning ]

  rule {
    id       = "cmb-saa-src-web-dr"
    status   = "Enabled"

    destination {
      bucket = module.s3_destination.bucket.arn
    }

    delete_marker_replication {
      status = "Disabled"
    }

    filter {}   # Required to be recognised as v2 replication configuration
  }
}

