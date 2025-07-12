# === tags - start ===
variable "tags" {
  type = map(string)
}

# === tags - end ===



variable "environment" {
  description = "Deployment environment"
  type        = string
}

# API Gateway 配置
variable "create_api_gateway" {
  description = "Whether to create API Gateway for the Lambda"
  type        = bool
  default     = false
}

variable "create_lambda_function_url" {
  description = "Whether to create Lambda function URL with streaming support"
  type        = bool
  default     = false
}
