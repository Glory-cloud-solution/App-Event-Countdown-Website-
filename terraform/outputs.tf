output "s3_bucket_name" {
  description = "Name of the S3 bucket hosting the NeoCloud Event Page"
  value       = aws_s3_bucket.neocloud_event_page.bucket
}

# Will enable this after CloudFront is created again
# output "cloudfront_distribution_domain_name" {
#   value = aws_cloudfront_distribution.cdn_distribution.domain_name
# }

# output "website_url" {
#   description = "Full URL to access the NeoCloud event landing page"
#   value       = "https://${aws_cloudfront_distribution.cdn_distribution.domain_name}"
# }

# Enable after Lambda is recreated
# output "lambda_function_name" {
#   description = "Name of the Lambda function handling form submissions"
#   value       = aws_lambda_function.form_submission_lambda.function_name
# }

output "rest_api_invoke_url" {
  description = "REST API full invoke URL for form submissions"
  value       = "https://${aws_api_gateway_rest_api.registration_api.id}.execute-api.${var.region}.amazonaws.com/prod/register"
}

output "registration_api_url" {
  description = "Full REST API URL to invoke the registration Lambda"
  value       = "https://${aws_api_gateway_rest_api.registration_api.id}.execute-api.${var.region}.amazonaws.com/prod/register"
}

