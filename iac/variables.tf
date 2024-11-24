variable "daily_trigger_lambda_policy" {
  description = "Daily trigger lambda policy"
  type = string
  default = "my-discord-bot-core-daily-trigger-lambda-policy"
}

variable "daily_trigger_scheduler_policy" {
  description = "Daily trigger scheduler policy"
  type = string
  default = "my-discord-bot-core-daily-trigger-scheduler-policy"
}


variable "daily_trigger_lambda_iam_role" {
  description = "IAM Role daily trigger lambda"
  type = string
  default = "daily-trigger-lambda-iam-role"
}

variable "daily_trigger_scheduler_iam_role" {
  description = "IAM Role daily trigger scheduler"
  type = string
  default = "daily-trigger-scheduler-iam-role"
}

variable "daily_trigger_lambda" {
 description = "Main lambda function name"
 type = string
 default = "daily-trigger-lambda"
}

variable "daily_trigger_scheduler_schedule" {
 description = "Daily trigger scheduler-schedule" 
 type = string
 default = "daily-trigger-scheduler-schedule"
}

variable "daily_trigger_lambda_zip_file" {
  description = "The zipped file of source code"
  type = string
  default = "../discord_chat_bot.zip"
}

variable "aws_region" {
  description = "Default aws region"
  type = string
  default = "ap-southeast-1"
}


