
output "lambda_security_group_id" {
  description = "ID of the security group for Lambda functions"
  value       = aws_security_group.lambda_sg.id
}
