variable "function_role_name" {
  description = "Role name of this function"
  type = string
  nullable = false
}

variable "function_role_policy" {
  description = "Policy of this function"
  type = string
  nullable = false
}

variable "function_name" {
  description = "Name of this scheduled function"
  type = string
  nullable = false
}

variable "scheduler_name" {
  description = "Name of this scheduler"
  type = string
  nullable = false
}

variable "scheduler_role_name" {
  description = "Role name of this function"
  type = string
  nullable = false
}

variable "scheduler_role_policy" {
  description = "Role policy of this scheduler role "
  type = string
  nullable = false
}

variable "function_policy_name" {
  description = "Name of this function policy"
  type = string
  nullable = false
}

variable "function_policy" {
  description = "Policy of this function"
  type = string
  nullable = false
}

variable "scheduler_policy_name" {
  description = "Name of this scheduler policy"
  type = string
  nullable = false
}


variable "handler" {
  description = "Handler of this function"
  type = string
  nullable = false
}

variable "timeout" {
  description = "Timeout of this function"
  type = number
  default = 30
  nullable = false
}

variable "memory_size" {
  description = "Memory size of this function"
  type = number
  default = 128
  nullable = false
}

variable "file_location" {
  description = "The location of file to deploy this function"
  type = string
  nullable = false
}

variable "environment_values" {
  description = "Environment values"
  type = map(string)
  nullable = true
}

variable "runtime" {
  description = "Runtime of this function"
  type = string
  nullable = false
}

variable "mode" {
  description = "Flexible time window mode"
  type = string
  default = ""
  nullable = false
}

variable "schedule_expression" {
  description = "Schedule expression"
  type = string
  nullable = false
}

variable "schedule_expression_timezone" {
  description = "Timezone of this schedule"
  type = string
  nullable = false
}