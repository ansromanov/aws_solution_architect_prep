data "terraform_remote_state" "tf_vpc" {
  backend = "local"

  config = {
    path = "${path.module}/../tf-vpc/terraform.tfstate"
  }
}

data "aws_vpc" "training" {
  id = data.terraform_remote_state.tf_vpc.outputs.vpc_id
}

data "aws_subnet" "training_private" {
  vpc_id = data.terraform_remote_state.tf_vpc.outputs.vpc_id
  tags = {
    "Name" = "training_private"
  }
}

data "aws_subnet_ids" "training_private" {
  vpc_id = data.terraform_remote_state.tf_vpc.outputs.vpc_id
  tags = {
    "Name" = "training_private"
  }
}