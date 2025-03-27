
# █░░ ▄▀█ █▀▄▀█ █▄▄ █▀▄ ▄▀█   █▀▀ █░█ █▄░█ █▀▀ ▀█▀ █ █▀█ █▄░█ 
# █▄▄ █▀█ █░▀░█ █▄█ █▄▀ █▀█   █▀░ █▄█ █░▀█ █▄▄ ░█░ █ █▄█ █░▀█ 

# Email Reminder Function
resource "aws_lambda_function" "email_reminder" {
  function_name = "saa-email-reminder"
  role          = aws_iam_role.lambda_exec.arn
  architectures = [ "x86_64" ]

  # Runtime Environment
  runtime = "python3.9"
  handler = "lambda_function.lambda_handler"

  # Deployment Artefact
  filename         = data.archive_file.email_reminder.output_path
  source_code_hash = data.archive_file.email_reminder.output_base64sha256
}

# Email Reminder Artefact
data "archive_file" "email_reminder" {
  type = "zip"
  output_path = "data/email_reminder.zip"

  source {
    filename = "lambda_function.py"
    content = templatefile("data/email_reminder.py", {
      from_email_address = aws_sesv2_email_identity.sender.email_identity
    })
  }
}

# ---

# API Gateway Function
resource "aws_lambda_function" "api_handler" {
  function_name = "saa-api-handler"
  role          = aws_iam_role.lambda_exec.arn
  architectures = [ "x86_64" ]

  # Runtime Environment
  runtime = "python3.11"
  handler = "lambda_function.lambda_handler"

  # Deployment Artefact
  filename         = data.archive_file.api_handler.output_path
  source_code_hash = data.archive_file.api_handler.output_base64sha256
}

# API Gateway Artefact
data "archive_file" "api_handler" {
  type = "zip"
  output_path = "data/api_handler.zip"

  source {
    filename = "lambda_function.py"
    content = templatefile("data/api_handler.py", {
      statemachine_arn = aws_sfn_state_machine.cuddleotron.arn
    })
  }
}

# API Gateway Invoke Permission
resource "aws_lambda_permission" "api_petcuddleotron_post_lambda" {
  function_name = aws_lambda_function.api_handler.function_name
  statement_id  = "AllowInvocationFromAPIGateway"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  source_arn    = join("", [
    "arn:aws:execute-api:",
    data.aws_region.current.name, ":",
    data.aws_caller_identity.current.account_id, ":",
    aws_api_gateway_rest_api.cuddleotron.id, "/*/",
    aws_api_gateway_method.petcuddleotron_post.http_method,
    aws_api_gateway_resource.petcuddleotron.path
  ])
}

