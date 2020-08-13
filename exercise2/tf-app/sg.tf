resource "aws_security_group" "private_server_access" {
  name        = "private-server-access"
  description = "SG for private server access"
  vpc_id      = data.terraform_remote_state.tf_vpc.outputs.vpc_id
  tags        = merge({ Name = "private_server_access" }, local.tags)
}

resource "aws_security_group_rule" "private_server_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.private_server_access.id
  cidr_blocks       = concat([local.vpc_cidr_block], local.allowed_ip_list)
}

resource "aws_security_group_rule" "private_server_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.private_server_access.id
  cidr_blocks       = [local.vpc_cidr_block]
}


resource "aws_security_group_rule" "private_server_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.private_server_access.id
  cidr_blocks       = [local.vpc_cidr_block]
}

resource "aws_security_group_rule" "private_server_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.private_server_access.id
  cidr_blocks       = ["0.0.0.0/0"]
}
