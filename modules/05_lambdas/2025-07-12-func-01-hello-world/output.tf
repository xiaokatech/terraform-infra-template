output "lambda_name" {
  description = "Name of the microservice"
  value       = "${local.service_name}-${var.environment}"
}

