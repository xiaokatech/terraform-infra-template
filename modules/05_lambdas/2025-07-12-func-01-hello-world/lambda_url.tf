# Create Lambda function URL with streaming support
resource "aws_lambda_function_url" "streaming_url" {
  count = var.create_lambda_function_url ? 1 : 0

  function_name      = aws_lambda_function.service.function_name
  authorization_type = "NONE" # Options: NONE or AWS_IAM

  # Enable streaming responses
  invoke_mode = "RESPONSE_STREAM"

  # Optional: Configure CORS
  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["*"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }
}


# Output the function URL
output "lambda_url" {
  value = aws_lambda_function_url.streaming_url[0].function_url
}
