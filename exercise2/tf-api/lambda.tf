resource "aws_cloudwatch_log_group" "example" {
  name              = local.lambda_url
  retention_in_days = 14
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<-EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",  
          "Action": [
            "logs:CreateLogGroup"
          ],
          "Resource": "arn:aws:logs:${local.log_group_base}:*"
        },
        {
          "Effect": "Allow",
          "Action": [
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ],
          "Resource": "arn:aws:logs:${local.log_group_base}:log-group:${local.lambda_url}:*"
        }
      ]
    }
    EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

resource "aws_iam_policy" "describe_instances" {
  name        = "describe_instances"
  path        = "/"
  description = "IAM policy for describing instances from a lambda"

  policy = <<-EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": [
            "ec2:DescribeInstances"
          ],
          "Effect": "Allow",
          "Resource": "*"
        }
      ]
    }
    EOF
}

resource "aws_iam_role_policy_attachment" "describe_instances" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.describe_instances.arn
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<-EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "lambda.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
        }
      ]
    }
    EOF
}

resource "aws_lambda_permission" "allow_api_gateway" {
  statement_id  = "AllowMetadataAPIInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get_ip_addresses.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/*/*"
}

resource "aws_lambda_function" "get_ip_addresses" {
  filename                       = "data/get_ip_addresses.zip"
  function_name                  = var.lambda_function_name
  handler                        = "get_ip_addresses.lambda_handler"
  memory_size                    = "128"
  reserved_concurrent_executions = "-1"
  role                           = aws_iam_role.iam_for_lambda.arn
  runtime                        = "python3.8"
  source_code_hash               = filebase64sha256("data/get_ip_addresses.zip")
  timeout                        = "3"

  tracing_config {
    mode = "PassThrough"
  }


  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs,
    aws_iam_role_policy_attachment.describe_instances,
    aws_cloudwatch_log_group.example,
  ]

  tags = local.tags
}