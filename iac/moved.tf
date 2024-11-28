moved {
    from = aws_iam_policy.daily_trigger_lambda_policy
    to = aws_iam_policy.trigger_worker_lambda_policy
}

moved {
    from = aws_iam_policy.daily_trigger_scheduler_policy
    to = aws_iam_policy.trigger_worker_scheduler_policy
}

moved {
    from = aws_iam_role.daily_trigger_lambda_role
    to = aws_iam_role.trigger_worker_lambda_role
}

moved {
    from = aws_iam_role.daily_trigger_scheduler_role
    to = aws_iam_role.trigger_worker_scheduler_role
}

moved {
  from = aws_iam_role_policy_attachment.daily_trigger_attachment
  to = aws_iam_role_policy_attachment.trigger_worker_attachment
}

moved {
  from = aws_iam_role_policy_attachment.daily_trigger_scheduler_attachment
  to = aws_iam_role_policy_attachment.trigger_worker_scheduler_attachment
}

moved {
    from = aws_lambda_function.daily_trigger_lambda
    to = aws_lambda_function.trigger_worker_lambda
}

moved {
  from = aws_scheduler_schedule.daily_trigger_scheduler
  to = aws_scheduler_schedule.trigger_worker_scheduler
}

