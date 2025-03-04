
# █▀▀ █░░ █▀█ █░█ █▀▄ █░█░█ ▄▀█ ▀█▀ █▀▀ █░█ 
# █▄▄ █▄▄ █▄█ █▄█ █▄▀ ▀▄▀▄▀ █▀█ ░█░ █▄▄ █▀█ 

resource "aws_cloudwatch_log_group" "cloudtrail_logs" {
  name = "aws-cloudtrail-logs-org"
}

