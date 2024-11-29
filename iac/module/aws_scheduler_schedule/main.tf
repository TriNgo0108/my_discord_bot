resource "aws_scheduler_schedule" "scheduler_schedule" {
  name = var.name
  flexible_time_window {
    mode = var.mode
  }
  target {
   arn = var.target_arn
   role_arn = var.scheduler_iam_role_arn
  }
  schedule_expression = var.schedule_expression
  schedule_expression_timezone = var.schedule_expression_timezone
}