provider "aws" {
    region = var.aws_region

}

resource "aws_iam_policy" "daily_trigger_lambda_policy" {
  name = var.daily_trigger_lambda_policy

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

  resource "aws_iam_role" "daily_trigger_lambda_role" {
  name = var.daily_trigger_lambda_iam_role
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

resource "aws_iam_role_policy_attachment" "daily_trigger_attachment" {
  role       = aws_iam_role.daily_trigger_lambda_role.name
  policy_arn = aws_iam_policy.daily_trigger_lambda_policy.arn
}

resource "aws_lambda_function" "daily_trigger_lambda" {
  function_name = var.daily_trigger_lambda
  role          = aws_iam_role.daily_trigger_lambda_role.arn
  handler       = "index.mjs" 
  runtime       = "nodejs20.x"
  timeout       = 300                              
  memory_size   = 128        
  filename      = var.daily_trigger_lambda_zip_file
  source_code_hash = filesha256(var.daily_trigger_lambda_zip_file)                      
  environment {
    variables = {
      "DISCORD_TOKEN" = var.discord_token
      "GUILD_ID" = var.guild_id
      "ENVIRONMENT" = var.environment
    }
  }
}


resource "aws_iam_role" "daily_trigger_scheduler_role" {
  name = var.daily_trigger_scheduler_iam_role
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


resource "aws_iam_policy" "daily_trigger_scheduler_policy" {
  name = var.daily_trigger_scheduler_policy
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
            "lambda:InvokeFunction"
        ],
        Resource = aws_lambda_function.daily_trigger_lambda.arn
        Effect   = "Allow"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "daily_trigger_scheduler_attachment" {
  role       = aws_iam_role.daily_trigger_scheduler_role.name
  policy_arn = aws_iam_policy.daily_trigger_scheduler_policy.arn
}


resource "aws_scheduler_schedule" "daily_trigger_scheduler" {
  name = var.daily_trigger_scheduler_schedule
  flexible_time_window {
    mode = "OFF"
  }
  target {
   arn = aws_lambda_function.daily_trigger_lambda.arn
   role_arn = aws_iam_role.daily_trigger_scheduler_role.arn
  }
  schedule_expression = "cron(58 6 ? * * *)"
}


terraform {
backend "s3" {
  bucket = "my-discord-bot-core-terraform-state"
  region = "ap-southeast-1"
  key = "terraform.tfstate"

    }
}