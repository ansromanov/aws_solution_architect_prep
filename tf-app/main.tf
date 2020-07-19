/**
* ## Description
* This module is used to create sample Application for AWS Solution Architech Associate exam
*
* It creates:
* - private instance with httpd
* - public instance with httpd
*/

resource "aws_instance" "instance_public" {
  ami                         = local.ami
  availability_zone           = "eu-north-1a"
  ebs_optimized               = true
  instance_type               = local.instance_type
  monitoring                  = local.cloudwatch_detailed_monitoring
  key_name                    = "dbtsolarch"
  subnet_id                   = data.aws_subnet.training_public.id
  vpc_security_group_ids      = [aws_security_group.public_server_access.id]
  associate_public_ip_address = true
  source_dest_check           = true

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }

  user_data = file("${path.module}/data/user_data.tpl")

  tags = merge({ Name = "instance_public" }, local.tags)

}

resource "aws_instance" "instance_private" {
  for_each = toset(["alpha"])
  # for_each = toset(["alpha", "beta", "omega"])

  ami               = local.ami
  availability_zone = "eu-north-1a"

  ebs_optimized               = true
  instance_type               = local.instance_type
  monitoring                  = local.cloudwatch_detailed_monitoring
  key_name                    = "dbtsolarch"
  subnet_id                   = data.aws_subnet.training_private.id
  vpc_security_group_ids      = [aws_security_group.private_server_access.id]
  source_dest_check           = true
  associate_public_ip_address = false

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }

  user_data = file("${path.module}/data/user_data.tpl")

  tags = merge({ Name = "instance_private_${each.key}" }, local.tags)

}
