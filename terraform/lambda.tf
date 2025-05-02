resource "aws_lambda_function" "form_submission_lambda" {
  function_name = var.lambda_function_name
  handler       = "index.lambda_handler"
  runtime       = "python3.12"
  role          = aws_iam_role.lambda_exec_role.arn
  filename      = "${path.module}/lambda_function_payload.zip"

  environment {
    variables = {
      SNS_TOPIC_ARN  = aws_sns_topic.registration_topic.arn
      EMAIL1         = var.lambda_email_1
      EMAIL2         = var.lambda_email_2
      DYNAMODB_TABLE = var.dynamodb_table_name
    }
  }

  tags = {
    Name        = "NeoApp Form Submission Lambda"
    Environment = "Production"
  }
}

