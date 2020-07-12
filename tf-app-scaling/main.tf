/**
* ## Description
* This module is used to create sample Application for AWS Solution Architech Associate exam
*
* It creates:
* - public ASG with httpd
*/
terraform {
  required_version = ">= 0.12, < 0.13"
}
provider "aws" {
  region  = "eu-north-1"
  version = "~> 2.60"
}


resource "aws_launch_configuration" "this" {
  image_id                    = var.ami
  instance_type               = "t3.micro"
  associate_public_ip_address = false
  security_groups             = [aws_security_group.this.id]
  key_name                    = var.ssh_key
  enable_monitoring           = false
  placement_tenancy           = "default"

  user_data = file("${path.module}/data/user_data.tpl")
  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_group" "this" {
  name                 = "${var.cluster_name}-${aws_launch_configuration.this.name}-asg"
  launch_configuration = aws_launch_configuration.this.name
  vpc_zone_identifier  = data.aws_subnet_ids.training_private.ids

  # target_group_arns = [aws_lb_target_group.this.arn]
  health_check_type = "ELB"

  min_size = 1
  max_size = 3

  # min_elb_capacity = var.asg_min_size

  dynamic "tag" {
    for_each = merge(var.custom_tags, local.tags)

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }

}