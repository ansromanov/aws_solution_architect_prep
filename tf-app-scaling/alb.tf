resource "aws_lb" "this" {
  name               = "${var.cluster_name}-alb"
  internal           = true
  load_balancer_type = "application"
  subnets            = data.aws_subnet_ids.training_private.ids
  security_groups    = [aws_security_group.alb.id]

  enable_deletion_protection = false

  tags = merge({ Name = var.cluster_name }, local.tags)
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.alb_port
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = "404"
    }
  }
}

resource "aws_lb_target_group" "this" {
  name     = "${var.cluster_name}-targetgroup"
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.tf_vpc.outputs.vpc_id

  health_check {
    path                = "/"
    port                = var.server_port
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener_rule" "this" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

}