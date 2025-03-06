
# █ █▀▄ █▀▀ █▄░█ ▀█▀ █ ▀█▀ █▄█   ▄▀█ █▀▀ █▀▀ █▀▀ █▀ █▀   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀ 
# █ █▄▀ ██▄ █░▀█ ░█░ █ ░█░ ░█░   █▀█ █▄▄ █▄▄ ██▄ ▄█ ▄█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░ 

# CloudTrail Logs Role
resource "aws_iam_role" "cloudtrail_cloudwatch_logs" {
  name        = "CloudTrailRoleForCloudWatchLogs_SAAOrg"
  description = "Role for config CloudWathLogs for trail ${ local.trail_name }"
  path        = "/service-role/"

  # Trust Policy
  assume_role_policy = file("json/cloudtrail_trust.json")
}

# Policy Attachment
resource "aws_iam_role_policy_attachment" "cloudtrail_cloudwatch_logs" {
  role       = aws_iam_role.cloudtrail_cloudwatch_logs.name
  policy_arn = aws_iam_policy.cloudtrail_cloudwatch_logs.arn
}

# CloudTrail Access to CloudWatch Logs
resource "aws_iam_policy" "cloudtrail_cloudwatch_logs" {
  name        = "CloudTrail-CW-access-policy-${ local.trail_name }"
  description = "Policy for config CloudWathLogs for trail ${ local.trail_name }"
  path        = "/service-role/"

  policy = templatefile("json/cloudtrail_cloudwatch_access.json", {
    aws_account_id      = data.aws_caller_identity.this.account_id
    aws_organisation_id = data.aws_organizations_organization.this.id
    log_group_name      = aws_cloudwatch_log_group.cloudtrail_logs.name
  })

  lifecycle {
    create_before_destroy = true
  }
}

