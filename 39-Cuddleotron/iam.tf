
# █ █▀▄ █▀▀ █▄░█ ▀█▀ █ ▀█▀ █▄█   ▄▀█ █▀▀ █▀▀ █▀▀ █▀ █▀   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀ 
# █ █▄▀ ██▄ █░▀█ ░█░ █ ░█░ ░█░   █▀█ █▄▄ █▄▄ ██▄ ▄█ ▄█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░ 

# Lambda Execution Role
resource "aws_iam_role" "lambda_exec" {
  name               = "SAACuddleOTron_LambdaExecutionRole"
  assume_role_policy = file("json/lambda-trust-policy.json")
}

# Inline CloudWatch Logs Policy
resource "aws_iam_role_policy" "cloudwatch_logs" {
  name   = "SAACuddleOTron_CloudWatchLogs"
  role   = aws_iam_role.lambda_exec.id
  policy = file("json/lambda-logs-policy.json")
}

# Inline SES, SNS, Step Fn State Machines Policy
resource "aws_iam_role_policy" "permissions" {
  name   = "SAACuddleOTron_Permissions"
  role   = aws_iam_role.lambda_exec.id
  policy = file("json/lambda-permissions-policy.json")
}

# ---

# StepFn State Machine Role
resource "aws_iam_role" "state_machine" {
  name               = "SAACuddleOTron_StateMachineRole"
  assume_role_policy = file("json/states-trust-policy.json")
}

# Inline CloudWatch Logs Policy
resource "aws_iam_role_policy" "states_cloudwatch_logs" {
  name   = "SAACuddleOTron_StateMachineCloudWatchLogs"
  role   = aws_iam_role.state_machine.id
  policy = file("json/states-logs-policy.json")
}

# Inline Permissions Logs Policy
resource "aws_iam_role_policy" "states_permissions" {
  name   = "SAACuddleOTron_StateMachinePermissions"
  role   = aws_iam_role.state_machine.id
  policy = file("json/states-permissions-policy.json")
}

