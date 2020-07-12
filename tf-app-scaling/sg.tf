resource "aws_security_group" "this" {
  name        = "private-server-access"
  description = "SG for private server access"
  vpc_id      = data.terraform_remote_state.tf_vpc.outputs.vpc_id
  tags        = merge({ Name = "private-server-access" }, local.tags)
}

resource "aws_security_group_rule" "private_server_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  cidr_blocks       = concat([local.vpc_cidr_block], local.allowed_ip_list)
}

resource "aws_security_group_rule" "private_server_http" {
  type              = "ingress"
  from_port         = var.server_port
  to_port           = var.server_port
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  cidr_blocks       = [local.vpc_cidr_block]
}


resource "aws_security_group_rule" "private_server_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.this.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "alb" {
  name_prefix = "terraform-example-alb"
  description = "Allow alb inbound traffic"
}

resource "aws_security_group_rule" "alb_http" {
  type        = "ingress"
  from_port   = var.alb_port
  to_port     = var.alb_port
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.alb.id
}
resource "aws_security_group_rule" "alb_egress" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.alb.id
}