resource "aws_sns_topic" "registration_topic" {
  name = "neoapp-event-registration-topic"

  tags = {
    Name        = "NeoApp Event SNS"
    Environment = "Production"
  }
}

resource "aws_sns_topic_subscription" "subscription_annie" {
  topic_arn = aws_sns_topic.registration_topic.arn
  protocol  = "email"
  endpoint  = var.lambda_email_1
}

resource "aws_sns_topic_subscription" "subscription_glory" {
  topic_arn = aws_sns_topic.registration_topic.arn
  protocol  = "email"
  endpoint  = var.lambda_email_2
}
