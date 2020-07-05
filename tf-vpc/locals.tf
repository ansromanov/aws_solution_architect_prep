locals {
  vpc_cidr_block            = "10.1.0.0/24"
  private_subnet_cidr_block = "10.1.0.0/26"
  public_subnet_cidr_block  = "10.1.0.64/26"

  tags = {
    Env     = "dev"
    Service = "network"
  }
}