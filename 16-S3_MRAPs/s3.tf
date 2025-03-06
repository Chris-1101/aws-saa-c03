
# █▀ █ █▀▄▀█ █▀█ █░░ █▀▀   █▀ ▀█▀ █▀█ █▀█ ▄▀█ █▀▀ █▀▀   █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ 
# ▄█ █ █░▀░█ █▀▀ █▄▄ ██▄   ▄█ ░█░ █▄█ █▀▄ █▀█ █▄█ ██▄   ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ 

# ------- North Virginia -------

# S3 Bucket N. Virginia
resource "aws_s3_bucket" "mrap_east" {
  bucket        = "cmb-saa-mrap-east"
  force_destroy = true
}

# Default SSE-S3 Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "mrap_east" {
  bucket = aws_s3_bucket.mrap_east.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}

# Bucket Versioning
resource "aws_s3_bucket_versioning" "mrap_east" {
  bucket = aws_s3_bucket.mrap_east.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Cross-Region Replication
resource "aws_s3_bucket_replication_configuration" "mrap_east_to_mrap_west" {
  bucket = aws_s3_bucket.mrap_east.id
  role   = aws_iam_role.crr_east_to_west.arn

  depends_on = [ aws_s3_bucket_versioning.mrap_east ]

  rule {
    id       = "cmb-saa-mrap-east-to-west"
    status   = "Enabled"

    destination {
      bucket = aws_s3_bucket.mrap_west.arn

      metrics {
        status = "Enabled"   # Enable Replication Metrics and Notifications
      }
    }

    # Disable Delete Marker Replication
    delete_marker_replication {
      status = "Disabled"
    }

    # Enable Replica Modification Sync
    source_selection_criteria {
      replica_modifications {
        status = "Enabled"
      }
    }

    filter {}   # Required to be recognised as v2 replication configuration
  }
}


# ------- North California -------

# S3 Bucket N. California
resource "aws_s3_bucket" "mrap_west" {
  provider      = aws.ncali
  bucket        = "cmb-saa-mrap-west"
  force_destroy = true
}

# Default SSE-S3 Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "mrap_west" {
  provider = aws.ncali
  bucket   = aws_s3_bucket.mrap_west.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}

# Bucket Versioning
resource "aws_s3_bucket_versioning" "mrap_west" {
  provider = aws.ncali
  bucket   = aws_s3_bucket.mrap_west.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Cross-Region Replication
resource "aws_s3_bucket_replication_configuration" "mrap_west_to_mrap_east" {
  provider = aws.ncali
  bucket   = aws_s3_bucket.mrap_west.id
  role     = aws_iam_role.crr_west_to_east.arn

  depends_on = [ aws_s3_bucket_versioning.mrap_west ]

  rule {
    id       = "cmb-saa-mrap-west-to-east"
    status   = "Enabled"

    destination {
      bucket = aws_s3_bucket.mrap_east.arn

      metrics {
        status = "Enabled"   # Enable Replication Metrics and Notifications
      }
    }

    # Disable Delete Marker Replication
    delete_marker_replication {
      status = "Disabled"
    }

    # Enable Replica Modification Sync
    source_selection_criteria {
      replica_modifications {
        status = "Enabled"
      }
    }

    filter {}   # Required to be recognised as v2 replication configuration
  }
}


# ------- Multi-Region Access Point -------

resource "aws_s3control_multi_region_access_point" "this" {
  details {
    name = "mrap-demo-lesson"

    region {
      bucket = aws_s3_bucket.mrap_east.id
    }

    region {
      bucket = aws_s3_bucket.mrap_west.id
    }
  }
}

