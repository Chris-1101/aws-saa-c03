
# █▀▀ █░█ █▀▀ █▄░█ ▀█▀ █▄▄ █▀█ █ █▀▄ █▀▀ █▀▀ 
# ██▄ ▀▄▀ ██▄ █░▀█ ░█░ █▄█ █▀▄ █ █▄▀ █▄█ ██▄ 

# EC2 Protect Event Trigger
resource "aws_cloudwatch_event_rule" "ec2_protect" {
  name           = "saa-ec2-protect"
  description    = "Start protected EC2 instance"
  event_bus_name = "default"
  event_pattern  = templatefile("json/protected-event.json", {
    ec2_instance_one_id = aws_instance.one.id
  })
}

# EC2 Protect Event Target
resource "aws_cloudwatch_event_target" "ec2_protect" {
  rule     = aws_cloudwatch_event_rule.ec2_protect.name
  arn      = aws_lambda_function.ec2_protect.arn
  role_arn = aws_iam_role.eventbridge.arn
}

# EC2 Stop Cron Trigger
resource "aws_cloudwatch_event_rule" "ec2_stop_cron" {
  name                = "saa-ec2-stop-cron"
  description         = "Periodically stop EC2 instances"
  schedule_expression = "cron(10 22 ? * * *)"
}

# EC2 Stop Cron Target
resource "aws_cloudwatch_event_target" "ec2_stop" {
  rule     = aws_cloudwatch_event_rule.ec2_stop_cron.name
  arn      = aws_lambda_function.ec2_stop.arn
  role_arn = aws_iam_role.eventbridge.arn
}

