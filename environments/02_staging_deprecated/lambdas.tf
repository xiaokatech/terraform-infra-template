locals {
  module_05_lambdas = {
    lambda_endpoints = {
      "${module.module_05_lambdas_func_01.lambda_name}" = {
        path_prefix = "/lambda_url/${module.module_05_lambdas_func_01.lambda_name}"
        endpoint    = module.module_05_lambdas_func_01.lambda_url
      }
    }
    lambda_endpoints = {
      "${module.module_05_lambdas_func_02.lambda_name}" = {
        path_prefix = "/lambda_url/${module.module_05_lambdas_func_02.lambda_name}"
        endpoint    = module.module_05_lambdas_func_02.lambda_url
      }
    }
  }
}


module "module_05_lambdas_func_01" {
  source = "../../modules/05_lambdas/2025-07-12-func-01-hello-world"

  environment = local.environment
  tags        = local.all_tags

  # API Gateway
  create_api_gateway         = false
  create_lambda_function_url = true
}

module "module_05_lambdas_func_02" {
  source = "../../modules/05_lambdas/2025-07-12-func-02-hello-world-stream"

  environment = local.environment
  tags        = local.all_tags

  # API Gateway
  create_api_gateway         = false
  create_lambda_function_url = true
}
