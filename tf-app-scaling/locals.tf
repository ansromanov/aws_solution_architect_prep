locals {
  instance_type                  = "t3.micro"
  cloudwatch_detailed_monitoring = false

  vpc_cidr_block = data.aws_vpc.training.cidr_block
  allowed_ip_list = [
    "188.242.43.66/32"
  ]

  tags = {
    Env     = "dev"
    Service = "application"
  }
}