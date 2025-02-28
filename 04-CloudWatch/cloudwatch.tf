
# █▀▀ █░░ █▀█ █░█ █▀▄ █░█░█ ▄▀█ ▀█▀ █▀▀ █░█ 
# █▄▄ █▄▄ █▄█ █▄█ █▄▀ ▀▄▀▄▀ █▀█ ░█░ █▄▄ █▀█ 

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name = "${ local.name }-highcpu"

  # Target
  namespace  = "AWS/EC2"
  dimensions = {
    "InstanceId" = aws_instance.this.id
  }

  # Metric
  metric_name         = "CPUUtilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 15
  period              = 300
  statistic           = "Average"
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  treat_missing_data  = "missing"

  # Actions
  actions_enabled = false
}

