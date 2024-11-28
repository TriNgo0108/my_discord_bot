variable "daily_trigger_lambda_policy" {
  description = "Daily trigger lambda policy"
  type = string
  default = "my-discord-bot-core-daily-trigger-lambda-policy"
}

variable "trigger_worker_lambda_policy" {
  description = "Trigger worker lambda policy"
  type = string
  default = "my-trigger-worker-core-daily-trigger-lambda-policy"
}

variable "daily_trigger_scheduler_policy" {
  description = "Daily trigger scheduler policy"
  type = string
  default = "my-discord-bot-core-daily-trigger-scheduler-policy"
}


variable "trigger_worker_scheduler_policy" {
  description = "Trigger Worker scheduler policy"
  type = string
  default = "my-trigger_worker-core-daily-trigger-scheduler-policy"
}


variable "daily_trigger_lambda_iam_role" {
  description = "IAM Role daily trigger lambda"
  type = string
  default = "daily-trigger-lambda-iam-role"
}
variable "trigger_worker_lambda_iam_role" {
  description = "IAM Role trigger worker lambda"
  type = string
  default = "trigger-worker-lambda-iam-role"
}

variable "daily_trigger_scheduler_iam_role" {
  description = "IAM Role daily trigger scheduler"
  type = string
  default = "daily-trigger-scheduler-iam-role"
}

variable "trigger_worker_scheduler_iam_role" {
  description = "IAM Role trigger worker scheduler"
  type = string
  default = "trigger-worker-scheduler-iam-role"
}

variable "daily_trigger_lambda" {
 description = "Main lambda function name"
 type = string
 default = "daily-trigger-lambda"
}

variable "trigger_worker_lambda" {
 description = "Main lambda function name"
 type = string
 default = "trigger-worker-lambda"
}

variable "daily_trigger_scheduler_schedule" {
 description = "Daily trigger scheduler-schedule" 
 type = string
 default = "daily-trigger-scheduler-schedule"
}
variable "trigger_worker_scheduler_schedule" {
 description = "trigger worker scheduler-schedule" 
 type = string
 default = "trigger-worker-scheduler-schedule"
}

variable "daily_trigger_lambda_zip_file" {
  description = "The zipped file of source code"
  type = string
  default = "../trigger-worker.zip"
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
  default = "https://my-discord-bot-latest.onrender.com"
}
