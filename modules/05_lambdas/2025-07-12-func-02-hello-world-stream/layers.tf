# @TOFIX
# resource "null_resource" "prepare_lambda_layer" {
#   triggers = {
#     # 当 package.json 或 package-lock.json 变更时触发
#     package_json_sha = filesha256("${local.src_path}/package.json")
#     package_lock_sha = fileexists("${local.src_path}/package-lock.json") ? filesha256("${local.src_path}/package-lock.json") : "none"
#   }

#   provisioner "local-exec" {
#     working_dir = local.src_path
#     command     = <<EOF
#       rm -rf ${local.src_path}/layer
#       mkdir -p ${local.src_path}/layer/nodejs
#       cp -r ${local.src_path}/node_modules ${local.src_path}/layer/nodejs/
#     EOF
#   }
# }


data "archive_file" "lambda_layer_node_modules" {
  type        = "zip"
  source_dir  = "${local.src_path}/layer/"
  output_path = "${local.src_path}/${local.service_name}_layer_node_modules-${var.environment}.zip"

  # 确保在打包前准备好目录结构
  #   depends_on = [null_resource.prepare_lambda_layer]
}

resource "aws_lambda_layer_version" "node_modules" {
  layer_name          = "${local.service_name}_node_modules"
  description         = "node_modules for ${local.service_name} Lambda function"
  filename            = data.archive_file.lambda_layer_node_modules.output_path
  source_code_hash    = data.archive_file.lambda_layer_node_modules.output_base64sha256
  compatible_runtimes = [local.runtime]
}
