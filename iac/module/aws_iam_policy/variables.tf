variable "policy_name" {
    description = "Name of IAM policy"
    type = string
    default = ""
    nullable = false

}

variable "policy" {
  description = "The path of the policy in IAM (tpl file)"
  type        = string
  default     = ""
  nullable = false
}