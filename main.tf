module "lambda" {
  source        = "./lambda"
}


module "eventbridge" {
  source = "./eventbridge" 
  lambda_function_arn = module.lambda.lambda_function_arn
  lambda_function_name = module.lambda.lambda_function_name
}

# Outputs
output "aws_lambda_function_arn" {
  value = module.lambda.lambda_function_arn
}

output "lambda_function_name" {
  value       = module.lambda.lambda_function_name
}
