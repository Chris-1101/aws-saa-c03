
# █▀█ █▀█ █▀▀ ▄▀█ █▄░█ █ █▀ ▄▀█ ▀█▀ █ █▀█ █▄░█ █▀ 
# █▄█ █▀▄ █▄█ █▀█ █░▀█ █ ▄█ █▀█ ░█░ █ █▄█ █░▀█ ▄█ 

# NOTE: keeping Terraform configs to a minimum for orgs
#  This only provides the policy creation, no attachments

# AllowAllExceptS3 Policy
resource "aws_organizations_policy" "deny_s3" {
  name        = "AllowAllExceptS3"
  description = "Allows access to every service except S3"
  content     = file("json/deny_s3.json")
}

