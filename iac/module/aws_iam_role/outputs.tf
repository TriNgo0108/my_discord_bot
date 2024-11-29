output "name" {
  description = "Name of this role"
  value = try(aws_iam_role.role[0].name, "")
}

output "arn" {
  description = "The ARN assigned by AWS to this role"
  value = try(aws_iam_role.role[0].arn, "")
}