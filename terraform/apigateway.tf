resource "aws_api_gateway_rest_api" "registration_api" {
  name        = "NeoCloud-Registration-RESTAPI"
  description = "REST API for NeoCloud registration form"
}

resource "aws_api_gateway_resource" "register_resource" {
  rest_api_id = aws_api_gateway_rest_api.registration_api.id
  parent_id   = aws_api_gateway_rest_api.registration_api.root_resource_id
  path_part   = "register"
}

resource "aws_api_gateway_method" "register_method" {
  rest_api_id   = aws_api_gateway_rest_api.registration_api.id
  resource_id   = aws_api_gateway_resource.register_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.registration_api.id
  resource_id             = aws_api_gateway_resource.register_resource.id
  http_method             = aws_api_gateway_method.register_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.form_submission_lambda.invoke_arn
}

resource "aws_lambda_permission" "allow_apigateway" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.form_submission_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.registration_api.execution_arn}/*/*"
}

# OPTIONS method for CORS
resource "aws_api_gateway_method" "options_method" {
  rest_api_id   = aws_api_gateway_rest_api.registration_api.id
  resource_id   = aws_api_gateway_resource.register_resource.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "options_mock" {
  rest_api_id             = aws_api_gateway_rest_api.registration_api.id
  resource_id             = aws_api_gateway_resource.register_resource.id
  http_method             = aws_api_gateway_method.options_method.http_method
  type                    = "MOCK"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_method_response" "options_response" {
  rest_api_id = aws_api_gateway_rest_api.registration_api.id
  resource_id = aws_api_gateway_resource.register_resource.id
  http_method = aws_api_gateway_method.options_method.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "options_integration_response" {
  depends_on = [aws_api_gateway_integration.options_mock]

  rest_api_id = aws_api_gateway_rest_api.registration_api.id
  resource_id = aws_api_gateway_resource.register_resource.id
  http_method = aws_api_gateway_method.options_method.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization'",
    "method.response.header.Access-Control-Allow-Methods" = "'POST,OPTIONS'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  response_templates = {
    "application/json" = ""
  }
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_integration.lambda_integration,
    aws_api_gateway_method.register_method,
    aws_api_gateway_method.options_method,
    aws_api_gateway_integration.options_mock
  ]

  rest_api_id = aws_api_gateway_rest_api.registration_api.id
  description = "Deployed API Gateway for NeoCloud form"
}

# ✅ Correct stage resource (instead of stage_name inside deployment)
resource "aws_api_gateway_stage" "prod" {
  deployment_id = aws_api_gateway_deployment.deployment.id
  rest_api_id   = aws_api_gateway_rest_api.registration_api.id
  stage_name    = "prod"
}

