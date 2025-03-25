
# █░░ ▄▀█ █▀▄▀█ █▄▄ █▀▄ ▄▀█   █▀▀ █░█ █▄░█ █▀▀ ▀█▀ █ █▀█ █▄░█ 
# █▄▄ █▀█ █░▀░█ █▄█ █▄▀ █▀█   █▀░ █▄█ █░▀█ █▄▄ ░█░ █ █▄█ █░▀█ 

# EC2 Stop Function
resource "aws_lambda_function" "ec2_stop" {
  function_name = "saa-ec2-stop"
  role          = aws_iam_role.lambda_exec.arn
  architectures = [ "x86_64" ]

  # Runtime Environment
  runtime = "python3.9"
  handler = "lambda_function.lambda_handler"

  # Deployment Artefact
  filename         = "data/01-Lambda_Instance_Stop.zip"
  source_code_hash = data.archive_file.ec2_stop.output_base64sha256

  # Environment Variables
  environment {
    variables = {
      EC2_INSTANCES = join(",", [ aws_instance.one.id, aws_instance.two.id ])
    }
  }
}

# EC2 Stop Artefact
data "archive_file" "ec2_stop" {
  type = "zip"
  source_file = "data/01-Lambda_Instance_Stop/lambda_function.py"
  output_path = "data/01-Lambda_Instance_Stop.zip"
}

# EC2 Start Function
resource "aws_lambda_function" "ec2_start" {
  function_name = "saa-ec2-start"
  role          = aws_iam_role.lambda_exec.arn
  architectures = [ "x86_64" ]

  # Runtime Environment
  runtime = "python3.9"
  handler = "lambda_function.lambda_handler"

  # Deployment Artefact
  filename         = "data/02-Lambda_Instance_Start.zip"
  source_code_hash = data.archive_file.ec2_start.output_base64sha256

  # Environment Variables
  environment {
    variables = {
      EC2_INSTANCES = join(",", [ aws_instance.one.id, aws_instance.two.id ])
    }
  }
}

# EC2 Start Artefact
data "archive_file" "ec2_start" {
  type = "zip"
  source_file = "data/02-Lambda_Instance_Start/lambda_function.py"
  output_path = "data/02-Lambda_Instance_Start.zip"
}

# EC2 Protect Function
resource "aws_lambda_function" "ec2_protect" {
  function_name = "saa-ec2-protect"
  role          = aws_iam_role.lambda_exec.arn
  architectures = [ "x86_64" ]

  # Runtime Environment
  runtime = "python3.9"
  handler = "lambda_function.lambda_handler"

  # Deployment Artefact
  filename         = "data/03-Lambda_Instance_Protect.zip"
  source_code_hash = data.archive_file.ec2_protect.output_base64sha256
}

# EC2 Protect Artefact
data "archive_file" "ec2_protect" {
  type = "zip"
  source_file = "data/03-Lambda_Instance_Protect/lambda_function.py"
  output_path = "data/03-Lambda_Instance_Protect.zip"
}

