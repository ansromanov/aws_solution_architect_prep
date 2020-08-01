terraform {
  required_version = ">= 0.12, < 0.13"
}
provider "aws" {
  region  = "eu-north-1"
  version = "~> 2.60"
}
