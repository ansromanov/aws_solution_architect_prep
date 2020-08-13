data "aws_iam_policy_document" "describe_ec2_instances" {
  version = "2012-10-17"
  statement {
    actions = [
      "ec2:DescribeInstances",
    ]

    resources = [
      "*",
    ]
    effect = "Allow"

  }
}

resource "aws_iam_policy" "describe_ec2_instances" {
  name        = "describe_ec2_instances"
  path        = "/"
  description = "Allow to describe EC2 instances"

  policy = data.aws_iam_policy_document.describe_ec2_instances.json
}

resource "aws_iam_role" "ec2_allow_to_describe_instances" {
  name               = "ec2_allow_to_describe_instances"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.ec2_allow_to_describe_instances.name
  policy_arn = aws_iam_policy.describe_ec2_instances.arn
}