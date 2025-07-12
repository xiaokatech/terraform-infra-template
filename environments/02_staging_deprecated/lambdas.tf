locals {
  module_05_lambdas = {
    lambda_endpoints = {
      "${module.module_05_lambdas.lambda_name}" = {
        path_prefix = "/lambda_url/${module.module_05_lambdas.lambda_name}"
        endpoint    = module.module_05_lambdas.lambda_url
      }
    }
  }
}


module "module_05_lambdas" {
  source = "../../modules/05_lambdas/2025-07-12-func-02-hello-world-stream"

  environment = local.environment
  tags        = local.all_tags

  # API Gateway
  create_api_gateway         = false
  create_lambda_function_url = true
}
