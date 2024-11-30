output "arn" {
  description = "ARN of this function"
  value = try(aws_lambda_function.lambda.arn)
}