variable "name" {
  description = "Name of this scheduler schedule"
  type = string
  default = ""
  nullable = false
}

variable "mode" {
  description = "Flexible time window mode"
  type = string
  default = ""
  nullable = false
}

variable "target_arn" {
  description = "ARN's target"
  type = string
  default = ""
  nullable = false
}

variable "scheduler_iam_role_arn" {
  description = "Iam role's Scheduler "
  type = string
  default = ""
  nullable = false
}

variable "schedule_expression" {
  description = "Schedule expression"
  type = string
  default = ""
  nullable = false
}

variable "schedule_expression_timezone" {
  description = "Timezone of this schedule"
  type = string
  default = ""
  nullable = false
}