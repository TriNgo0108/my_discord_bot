variable "function_name" {
  description = "Function name"
  type = string
  nullable = false
}

variable "function_role_arn" {
  description = "Function role arn"
  type = string
  nullable = false
}

variable "handler" {
  description = "Handler of this function"
  type = string
  nullable = false
}

variable "runtime" {
  description = "Runtime for this function"
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
  nullable = false
}