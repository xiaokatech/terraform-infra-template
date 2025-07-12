locals {
  runtime  = "nodejs22.x"
  src_path = "${path.module}/src"

  service_name = "2025-07-12-func-02-hello-world-stream"

  function_name = "${local.service_name}-${var.environment}"
}

# 编译TypeScript为JavaScript (使用null_resource和本地执行器)
# @FIXME: 这里使用了null_resource来触发TypeScript编译，无法正常生成 index.js 文件，需手动生成
# resource "null_resource" "compile_typescript" {
#   triggers = {
#     src_hash = "${sha256(file("${local.src_path}/index.ts"))}"
#   }

#   provisioner "local-exec" {
#     working_dir = local.src_path
#     command     = "npx tsc index.ts"
#   }
# }

# 创建一个简单的Lambda函数
resource "aws_lambda_function" "service" {
  function_name = local.function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = local.runtime

  timeout = 180

  memory_size = 512


  # 内联代码定义
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  layers = [
    aws_lambda_layer_version.node_modules.arn,
  ]

  # 确保zip文件存在
  depends_on = [
    # local_file.lambda_function_code,
    # null_resource.compile_typescript,
    data.archive_file.lambda_zip,
  ]

  # 标签
  tags = merge(var.tags, {
    Name        = "${local.service_name}-${var.environment}"
    Environment = var.environment
    Service     = local.service_name
  })
}


# # 创建Lambda函数代码文件
# resource "local_file" "lambda_function_code" {
#   content  = <<EOF
# exports.handler = async (event) => {
#   return {
#     statusCode: 200,
#     body: JSON.stringify('Hello World'),
#   };
# };
# EOF
#   filename = "${path.module}/index.js"
# }

# 将代码打包成zip
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${local.src_path}/build/"
  output_path = "${local.src_path}/${local.service_name}-${var.environment}.zip"
}

# 输出Lambda函数ARN
output "lambda_function_arn" {
  value = aws_lambda_function.service.arn
}
