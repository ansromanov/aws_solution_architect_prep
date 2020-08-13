locals {
  tags = {
    Env     = "dev"
    Service = "application"
  }
  lambda_url     = "/aws/lambda/${var.lambda_function_name}"
  log_group_base = "${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}"
}