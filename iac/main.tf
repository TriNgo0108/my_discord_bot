provider "aws" {
    region = var.aws_region

}


resource "aws_iam_policy" "trigger_worker_lambda_policy" {
  name = var.trigger_worker_lambda_policy

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*"
        Effect   = "Allow"
      },
    ]
  })
}


resource "aws_iam_role_policy_attachment" "trigger_worker_attachment" {
  role       = aws_iam_role.trigger_worker_lambda_role.name
  policy_arn = aws_iam_policy.trigger_worker_lambda_policy.arn
}


resource "aws_lambda_function" "trigger_worker_lambda" {
  function_name = var.trigger_worker_lambda
  role          = aws_iam_role.trigger_worker_lambda_role.arn
  handler       = "index.handler" 
  runtime       = "nodejs20.x"
  timeout       = 300                              
  memory_size   = 128        
  filename      = var.trigger_worker_lambda_zip_file
  source_code_hash = filesha256(var.trigger_worker_lambda_zip_file)                      
  environment {
    variables = {
      "ENVIRONMENT" = var.environment
      "RENDER_BACKEND_ENDPOINT": var.worker_endpoint
    }
  }
}

resource "aws_iam_role" "trigger_worker_scheduler_role" {
  name = var.trigger_worker_scheduler_iam_role
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "scheduler.amazonaws.com"
        }
      }
    ]
  })
}

 resource "aws_iam_role" "trigger_worker_lambda_role" {
  name = var.trigger_worker_lambda_iam_role
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "trigger_worker_scheduler_policy" {
  name = var.trigger_worker_scheduler_policy
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
            "lambda:InvokeFunction"
        ],
        Resource = aws_lambda_function.trigger_worker_lambda.arn
        Effect   = "Allow"
      },
    ]
  })
}


resource "aws_iam_role_policy_attachment" "trigger_worker_scheduler_attachment" {
  role       = aws_iam_role.trigger_worker_scheduler_role.name
  policy_arn = aws_iam_policy.trigger_worker_scheduler_policy.arn
}


resource "aws_scheduler_schedule" "trigger_worker_scheduler" {
  name = var.trigger_worker_scheduler_schedule
  flexible_time_window {
    mode = "OFF"
  }
  target {
   arn = aws_lambda_function.trigger_worker_lambda.arn
   role_arn = aws_iam_role.trigger_worker_scheduler_role.arn
  }
  schedule_expression = "cron(*/13 * ? * * *)"
  schedule_expression_timezone = "Asia/Ho_Chi_Minh"
}
terraform {
backend "s3" {
  bucket = "my-discord-bot-core-terraform-state"
  region = "ap-southeast-1"
  key = "terraform.tfstate"

    }
}