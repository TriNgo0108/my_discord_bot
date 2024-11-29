resource "aws_lambda_function" "lambda" {
  function_name = var.function_name
  role          = var.function_role_arn
  handler       = var.handler
  runtime       = var.runtime
  timeout       = var.memory_size
  memory_size   = var.memory_size
  filename      = var.file_location
  source_code_hash = filesha256(var.file_location)                      
  environment {
    variables = var.environment_values
  }
}