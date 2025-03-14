
# █▀▄ ▄▀█ ▀█▀ ▄▀█   █▀ █▀█ █░█ █▀█ █▀▀ █▀▀ █▀ 
# █▄▀ █▀█ ░█░ █▀█   ▄█ █▄█ █▄█ █▀▄ █▄▄ ██▄ ▄█ 

# S3 Read Only Access Policy
data "aws_iam_policy" "s3_read_only" {
  name = "AmazonS3ReadOnlyAccess"
}

