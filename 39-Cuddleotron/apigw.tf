
# ▄▀█ █▀█ █   █▀▀ ▄▀█ ▀█▀ █▀▀ █░█░█ ▄▀█ █▄█ 
# █▀█ █▀▀ █   █▄█ █▀█ ░█░ ██▄ ▀▄▀▄▀ █▀█ ░█░ 

# API Gateway REST API
resource "aws_api_gateway_rest_api" "cuddleotron" {
  name        = "saa-cuddleotron"
  description = "Pet CuddleOTron API for Adrian Cantrill's SAA demo"
  endpoint_configuration {
    types = [ "REGIONAL" ]
  }
}

# Production Stage
resource "aws_api_gateway_stage" "prod" {
  stage_name    = "prod"
  rest_api_id   = aws_api_gateway_rest_api.cuddleotron.id
  deployment_id = aws_api_gateway_deployment.initial.id
}

# Initial Deployment
resource "aws_api_gateway_deployment" "initial" {
  rest_api_id = aws_api_gateway_rest_api.cuddleotron.id
  description = "Initial production deployment"

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.cuddleotron.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

# --- /petcuddleoton

# API Gateway Resource /petcuddleotron
resource "aws_api_gateway_resource" "petcuddleotron" {
  path_part   = "petcuddleotron"
  rest_api_id = aws_api_gateway_rest_api.cuddleotron.id # "dn3hbs2nd0"
  parent_id   = aws_api_gateway_rest_api.cuddleotron.root_resource_id # "5zenth1c47"
}

# --- OPTIONS

# OPTIONS /petcuddleotron
resource "aws_api_gateway_method" "petcuddleotron_options" {
  rest_api_id   = aws_api_gateway_rest_api.cuddleotron.id
  resource_id   = aws_api_gateway_resource.petcuddleotron.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

# OPTIONS /petcuddleotron 200 Response
resource "aws_api_gateway_method_response" "petcuddleotron_options_200" {
  rest_api_id = aws_api_gateway_rest_api.cuddleotron.id
  resource_id = aws_api_gateway_resource.petcuddleotron.id
  http_method = aws_api_gateway_method.petcuddleotron_options.http_method
  status_code = "200"

  # Response Headers
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false   # false = optional
    "method.response.header.Access-Control-Allow-Methods" = false   # true = required
    "method.response.header.Access-Control-Allow-Origin"  = false   # Enables CORS
  }

  # Response Body
  response_models = {
    "application/json" = "Empty"
  }
}

# OPTIONS /petcuddleotron Integration
resource "aws_api_gateway_integration" "petcuddleotron_options" {
  rest_api_id          = aws_api_gateway_rest_api.cuddleotron.id
  resource_id          = aws_api_gateway_resource.petcuddleotron.id
  http_method          = aws_api_gateway_method.petcuddleotron_options.http_method
  type                 = "MOCK"
  timeout_milliseconds = 29000

  # Mapping Templates
  request_templates = {
    "application/json" = jsonencode({ statusCode = 200 })
  }
  passthrough_behavior = "WHEN_NO_MATCH"
}

# OPTIONS /petcuddleotron Integration 200 Response
resource "aws_api_gateway_integration_response" "petcuddleotron_options_200" {
  rest_api_id = aws_api_gateway_rest_api.cuddleotron.id
  resource_id = aws_api_gateway_resource.petcuddleotron.id
  http_method = aws_api_gateway_method.petcuddleotron_options.http_method
  status_code = "200"

  # Header Mappings
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
}

# --- POST

# POST /petcuddleotron
resource "aws_api_gateway_method" "petcuddleotron_post" {
  rest_api_id   = aws_api_gateway_rest_api.cuddleotron.id
  resource_id   = aws_api_gateway_resource.petcuddleotron.id
  http_method   = "POST"
  authorization = "NONE"
}

# POST /petcuddleotron 200 Response
resource "aws_api_gateway_method_response" "petcuddleotron_post_200" {
  rest_api_id = aws_api_gateway_rest_api.cuddleotron.id
  resource_id = aws_api_gateway_resource.petcuddleotron.id
  http_method = aws_api_gateway_method.petcuddleotron_post.http_method
  status_code = "200"

  # Response Body
  response_models = {
    "application/json" = "Empty"
  }
}

# POST /petcuddleotron Integration
resource "aws_api_gateway_integration" "petcuddleotron_post_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.cuddleotron.id
  resource_id             = aws_api_gateway_resource.petcuddleotron.id
  http_method             = aws_api_gateway_method.petcuddleotron_post.http_method
  timeout_milliseconds    = 29000

  # Lambda Integration
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.api_handler.invoke_arn
  content_handling        = "CONVERT_TO_TEXT"
}

