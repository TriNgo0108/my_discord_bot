variable "trigger_worker_lambda_policy" {
  description = "Trigger worker lambda policy"
  type = string
  default = "my-trigger-worker-core-daily-trigger-lambda-policy"
}


variable "trigger_worker_scheduler_policy" {
  description = "Trigger Worker scheduler policy"
  type = string
  default = "my-trigger_worker-core-daily-trigger-scheduler-policy"
}


variable "trigger_worker_lambda_iam_role" {
  description = "IAM Role trigger worker lambda"
  type = string
  default = "trigger-worker-lambda-iam-role"
}


variable "trigger_worker_scheduler_iam_role" {
  description = "IAM Role trigger worker scheduler"
  type = string
  default = "trigger-worker-scheduler-iam-role"
}


variable "trigger_worker_lambda" {
 description = "Main lambda function name"
 type = string
 default = "trigger-worker-lambda"
}


variable "trigger_worker_scheduler_schedule" {
 description = "trigger worker scheduler-schedule" 
 type = string
 default = "trigger-worker-scheduler-schedule"
}


variable "trigger_worker_lambda_zip_file" {
  description = "The zipped file of source code"
  type = string
  default = "../trigger-worker.zip"
}



variable "aws_region" {
  description = "Default aws region"
  type = string
  default = "ap-southeast-1"
}


variable "environment" {
  description = "Level of testing"
  type = string
  default = "Prod"
}

variable "worker_endpoint" {
  description = "The endpoint of worker"
  type = string
  default = "https://my-discord-bot-latest.onrender.com/health"
}

variable "daily_message_lambda_zip_file" {
  description = "The location of daily message zip file"
  type = string
  default = ""
}

variable "daily_message_scheduled_function_name" {
  description = "The name of daily message"
  type = string
  default = "daily-message-core"
}

variable "discord_token" {
  description = "Discord token uses login bot"
  type = string
  default = ""
}

variable "guild_id" {
  description = "Id of current guild"
  type = string
  default = ""
}

variable "openai_api_key" {
  description = "API key of OpenAI"
  type = string
  default = ""
}
variable "daily_message_scheduler_mode" {
  description = "Daily message scheduler mode"
  type = string
  default = ""
}

variable "drink_water_reminder_lambda_zip_file" {
  description = "The location of daily message zip file"
  type = string
  default = ""
}

variable "drink_water_reminder_function_name" {
  description = "The name of daily message"
  type = string
  default = "drink-water-reminder-core"
}

variable "drink_water_reminder_scheduler_mode" {
  description = "Daily message scheduler mode"
  type = string
  default = ""
}
