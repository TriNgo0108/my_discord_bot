output "id" {
  description = "The policy's ID"
  value       = try(aws_iam_policy.policy[0].id, "")
}

output "arn" {
  description = "The ARN assigned by AWS to this policy"
  value       = try(aws_iam_policy.policy[0].arn, "")
}

output "description" {
  description = "The description of the policy"
  value       = try(aws_iam_policy.policy[0].description, "")
}

output "name" {
  description = "The name of the policy"
  value       = try(aws_iam_policy.policy[0].name, "")
}