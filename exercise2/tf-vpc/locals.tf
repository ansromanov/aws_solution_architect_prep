locals {
  vpc_cidr_block              = "10.1.0.0/24"
  private_subnet_a_cidr_block = "10.1.0.0/26"
  private_subnet_b_cidr_block = "10.1.0.64/26"
  public_subnet_a_cidr_block  = "10.1.0.128/26"
  public_subnet_b_cidr_block  = "10.1.0.192/26"

  tags = {
    Env     = "dev"
    Service = "network"
  }
}