
# █▀█ █░█ ▀█▀ █▀█ █░█ ▀█▀ █▀ 
# █▄█ █▄█ ░█░ █▀▀ █▄█ ░█░ ▄█ 

output "lambda_api_handler_arn" {
  value       = aws_lambda_function.email_reminder.arn
  description = "ARN of the email reminder Lambda function"
}

output "lambda_email_reminder_arn" {
  value       = aws_lambda_function.email_reminder.arn
  description = "ARN of the email reminder Lambda function"
}

output "stepfn_cuddleotron_arn" {
  value       = aws_sfn_state_machine.cuddleotron.arn
  description = "ARN of the CuddleOTron state machine"
}

output "api_dns" {
  value       = aws_api_gateway_stage.prod.invoke_url
  description = "API root endpoint"
}

output "s3_frontend_dns" {
  value       = aws_s3_bucket_website_configuration.cuddleotron_frontend.website_endpoint
  description = "Frontend URL"
}

