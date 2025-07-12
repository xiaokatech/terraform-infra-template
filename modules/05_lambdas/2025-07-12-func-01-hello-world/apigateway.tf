# # API Gateway 触发器 (可选)
# resource "aws_apigatewayv2_api" "api" {
#   count         = var.create_api_gateway ? 1 : 0
#   name          = "${var.service_name}-${var.environment}-api"
#   protocol_type = "HTTP"

#   tags = var.tags

#   # 启用 CORS
#   cors_configuration {
#     allow_origins = ["*"]
#     allow_methods = ["GET", "POST", "OPTIONS"]
#     allow_headers = ["Content-Type", "Authorization", "X-Amz-Date", "X-Api-Key", "X-Amz-Security-Token"]
#     max_age       = 300
#   }
# }

# resource "aws_apigatewayv2_stage" "default" {
#   count       = var.create_api_gateway ? 1 : 0
#   api_id      = aws_apigatewayv2_api.api[0].id
#   name        = "$default"
#   auto_deploy = true

#   tags = var.tags
# }

# resource "aws_apigatewayv2_integration" "lambda" {
#   count                  = var.create_api_gateway ? 1 : 0
#   api_id                 = aws_apigatewayv2_api.api[0].id
#   integration_type       = "AWS_PROXY"
#   integration_uri        = aws_lambda_function.service.invoke_arn
#   integration_method     = "POST"
#   payload_format_version = "2.0"
#   # timeout_milliseconds   = 30000 # 30秒，最大值
# }

# resource "aws_apigatewayv2_route" "default" {
#   count     = var.create_api_gateway ? 1 : 0
#   api_id    = aws_apigatewayv2_api.api[0].id
#   route_key = "ANY /{proxy+}"
#   target    = "integrations/${aws_apigatewayv2_integration.lambda[0].id}"
# }

# # 允许 API Gateway 调用 Lambda
# resource "aws_lambda_permission" "api_gateway" {
#   count         = var.create_api_gateway ? 1 : 0
#   statement_id  = "AllowExecutionFromAPIGateway"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.service.function_name
#   principal     = "apigateway.amazonaws.com"
#   source_arn    = "${aws_apigatewayv2_api.api[0].execution_arn}/*/*"
# }

# # 创建路由
# # resource "aws_apigatewayv2_route" "route" {
# #   count     = var.create_api_gateway ? 1 : 0
# #   api_id    = aws_apigatewayv2_api.api.id
# #   route_key = "POST /chat" # 或者根据需要调整路径
# #   target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
# # }


