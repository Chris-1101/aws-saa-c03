
# █ █▀▄ █▀▀ █▄░█ ▀█▀ █ ▀█▀ █▄█   ▄▀█ █▀▀ █▀▀ █▀▀ █▀ █▀   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀ 
# █ █▄▀ ██▄ █░▀█ ░█░ █ ░█░ ░█░   █▀█ █▄▄ █▄▄ ██▄ ▄█ ▄█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░ 

# Lambda Execution Role
resource "aws_iam_role" "lambda_exec" {
  name               = "SAALambdaExecutionRole"
  assume_role_policy = file("json/lambda-trust-policy.json")
}

# Inline EC2 Start/Stop Permissions Policy
resource "aws_iam_role_policy" "lambda_start_stop" {
  name   = "saa-lambda-start-stop"
  role   = aws_iam_role.lambda_exec.id
  policy = file("json/lambda-policy.json")
}

# EventBridge Role
resource "aws_iam_role" "eventbridge" {
  name               = "SAAEventBridgeInvokeLambda"
  assume_role_policy = file("json/events-trust-policy.json")
}

# Inline EC2 Start/Stop Permissions Policy
resource "aws_iam_role_policy" "eventbridge_invoke" {
  name   = "saa-eventbridge-invoke-lambda"
  role   = aws_iam_role.eventbridge.id
  policy = templatefile("json/events-policy.json", {
    lambda_protect_arn = aws_lambda_function.ec2_protect.arn
    lambda_stop_arn    = aws_lambda_function.ec2_stop.arn
  })
}

