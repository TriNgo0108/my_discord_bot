variable "role_name" {
  description = "IAM Role name"
  type = string
  default = ""
  nullable = false
}

variable "policy" {
  description = "Policy attach to this role"
  type = string
  default = ""
  nullable = false
}