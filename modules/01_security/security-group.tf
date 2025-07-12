# 创建安全组
resource "aws_security_group" "lambda_sg" {
  name        = "${local.environment}-lambda-sg"
  description = "Security group for Lambda functions"
  vpc_id      = local.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, {
    Name        = "${local.environment}-lambda-sg"
    Environment = local.environment
  })
}



