
# █▀▀ █░░ █▀█ █░█ █▀▄ ▀█▀ █▀█ ▄▀█ █ █░░ 
# █▄▄ █▄▄ █▄█ █▄█ █▄▀ ░█░ █▀▄ █▀█ █ █▄▄ 

resource "aws_cloudtrail" "org" {
  name                  = local.trail_name
  enable_logging        = false
  is_organization_trail = true
  is_multi_region_trail = true

  # S3 Storage
  s3_bucket_name = aws_s3_bucket.cloudtrail_logs.id

  # CloudWatch Logs
  enable_log_file_validation = true
  cloud_watch_logs_role_arn  = aws_iam_role.cloudtrail_cloudwatch_logs.arn
  cloud_watch_logs_group_arn = "${ aws_cloudwatch_log_group.cloudtrail_logs.arn }:*"

  # Management Events
  advanced_event_selector {
    name = "Management events selector"

    field_selector {
      field  = "eventCategory"
      equals = ["Management"]
    }
  }
}

