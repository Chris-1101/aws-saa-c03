
# █▀ ▀█▀ █▀▀ █▀█   █▀▀ █░█ █▄░█ █▀▀ ▀█▀ █ █▀█ █▄░█ 
# ▄█ ░█░ ██▄ █▀▀   █▀░ █▄█ █░▀█ █▄▄ ░█░ █ █▄█ █░▀█ 

# SAA CuddleOTron StateMachine
resource "aws_sfn_state_machine" "cuddleotron" {
  name     = "SAACuddleOTron"
  type     = "STANDARD"
  role_arn = aws_iam_role.state_machine.arn

  # Amazon StateMachine Language Document
  definition = templatefile("json/states-definition.json", {
    email_lambda_arn = aws_lambda_function.email_reminder.arn
  })

  # Logging
  logging_configuration {
    level                  = "ALL"
    include_execution_data = true
    log_destination        = "${ aws_cloudwatch_log_group.state_machine.arn }:*"
  }
}

