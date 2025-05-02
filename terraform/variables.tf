variable "region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket to host the NeoCloud event website."
  type        = string
  default     = "neocloud-event-page"
}

variable "domain_name" {
  description = "The domain name for the NeoCloud event website."
  type        = string
  default     = "neocloudapp.site"
}

variable "certificate_arn" {
  description = "ACM Certificate ARN for CloudFront (must be in us-east-1)."
  type        = string
  default     = "arn:aws:acm:us-east-1:872515264603:certificate/945f2da1-ef94-4bc0-9f90-6cf2f37fef83"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function handling form submissions."
  type        = string
  default     = "neocloud-form-submission-handler"
}

variable "lambda_email_1" {
  description = "Primary email address to receive form submissions."
  type        = string
  default     = "annieussang@gmail.com"
}

variable "lambda_email_2" {
  description = "Secondary email address to receive form submissions."
  type        = string
  default     = "gloryugochukwu02@gmail.com"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table to store registration data."
  type        = string
  default     = "neoapp_registrations"
}

# Optional CORS configuration for API Gateway
variable "allowed_origins" {
  description = "List of allowed origins for CORS."
  type        = list(string)
  default     = ["https://neocloudapp.site", "https://www.neocloudapp.site"]
}

variable "api_stage_name" {
  description = "Name of the API Gateway stage."
  type        = string
  default     = "prod"
}

variable "api_name" {
  description = "Name of the API Gateway HTTP API."
  type        = string
  default     = "NeoCloud-Registration-HTTPAPI"
}
