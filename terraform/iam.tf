resource "aws_iam_role" "lambda_exec_role" {
  name = "neoapp-lambda-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })

  tags = {
    Name = "LambdaExecRole"
    Environment = "Production"
  }
}

# Basic Lambda logging
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# SNS Publish Permission
resource "aws_iam_policy" "sns_publish_policy" {
  name        = "LambdaSNSPublishPolicy"
  description = "Allow Lambda to publish to SNS topic"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sns:Publish",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_sns_attach" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.sns_publish_policy.arn
}

# DynamoDB Write Access
resource "aws_iam_policy" "dynamodb_write_policy" {
  name        = "LambdaDynamoDBWrite"
  description = "Allow Lambda to write to DynamoDB"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "dynamodb:PutItem"
        ],
        Resource = aws_dynamodb_table.neoapp_registrations.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb_attach" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.dynamodb_write_policy.arn
}
