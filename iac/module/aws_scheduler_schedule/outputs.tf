output "name" {
  description = "Name of this role"
  value = try(aws_scheduler_schedule.scheduler_schedule[0].name, "")
}

output "arn" {
  description = "The ARN assigned by AWS to this role"
  value = try(aws_scheduler_schedule.scheduler_schedule[0].arn, "")
}