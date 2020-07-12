/**
* ## Description
* This module is used to create sample VPC for AWS Solution Architech Associate exam
*
* It creates:
* - custom VPC
* - private subnet
* - public subnet
* - internet gateway
*/

resource "aws_vpc" "training" {
  cidr_block           = local.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  tags                 = merge({ Name = "training" }, local.tags)
}

resource "aws_internet_gateway" "training-igw" {
  vpc_id = aws_vpc.training.id

  tags = merge({ Name = "training-igw" }, local.tags)
}

resource "aws_nat_gateway" "training_nat" {
  count         = var.deploy_natgw ? 1 : 0
  allocation_id = "eipalloc-03d04b0a6d1eff76b"
  subnet_id     = "subnet-006368a384179c851"

  depends_on = [
    aws_internet_gateway.training-igw
  ]
}