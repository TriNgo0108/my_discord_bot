module "function_iam_role" {
  source = "../aws_iam_role"
  role_name = var.function_role_name
  policy = var.function_role_policy
}

module "function_iam_policy" {
  source = "../aws_iam_policy"
  policy_name = var.function_policy_name
  policy = var.function_policy
}

resource "aws_iam_role_policy_attachment" "function_attachment" {
  role       = module.function_iam_role.name
  policy_arn = module.function_iam_policy.arn
}

module "scheduled_function" {
  source = "../aws_lambda"
  function_name = var.function_name
  handler = var.handler
  runtime = var.runtime
  file_location = var.file_location
  environment_values = var.environment_values
  function_role_arn = module.function_iam_role.arn
}

module "scheduler_iam_role" {
  source = "../aws_iam_role"
  role_name = var.scheduler_role_name
  policy = var.scheduler_role_policy
}


module "scheduler_iam_policy" {
  source = "../aws_iam_policy"
  policy_name = var.scheduler_policy_name
  policy = var.scheduler_policy
}


resource "aws_iam_role_policy_attachment" "scheduler_attachment" {
  role       = module.scheduler_iam_role.name
  policy_arn = module.scheduler_iam_policy.arn
}

module "function_scheduler" {
  source = "../aws_scheduler_schedule"
  name = var.scheduler_name
  mode = var.mode
  target_arn = module.scheduled_function.arn
  scheduler_iam_role_arn = module.scheduler_iam_role.arn
  schedule_expression = var.schedule_expression
  schedule_expression_timezone = var.schedule_expression_timezonecl
}

