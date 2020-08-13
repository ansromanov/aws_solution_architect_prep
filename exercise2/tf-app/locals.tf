locals {
  instance_type                  = "t3.micro"
  cloudwatch_detailed_monitoring = false
  ami                            = "ami-04697c9bb5d6135a2"

  vpc_cidr_block = data.aws_vpc.training.cidr_block
  allowed_ip_list = [
    "188.242.43.66/32",
    "188.170.72.168/32"
  ]

  tags = {
    Env     = "dev"
    Service = "application"
  }
}