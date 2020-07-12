resource "aws_subnet" "training_private_a" {
  vpc_id                  = aws_vpc.training.id
  cidr_block              = local.private_subnet_a_cidr_block
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = false
  tags                    = merge({ Name = "training_private_a" }, local.tags)
}

resource "aws_route_table" "training_private_a_rt" {
  vpc_id = aws_vpc.training.id

  tags = merge({ Name = "training_private_a_rt" }, local.tags)
}

resource "aws_route_table_association" "training_private_a_rt" {
  route_table_id = aws_route_table.training_private_a_rt.id
  subnet_id      = aws_subnet.training_private_a.id
}
resource "aws_subnet" "training_private_b" {
  vpc_id                  = aws_vpc.training.id
  cidr_block              = local.private_subnet_b_cidr_block
  availability_zone       = "eu-north-1b"
  map_public_ip_on_launch = false
  tags                    = merge({ Name = "training_private_b" }, local.tags)
}

resource "aws_route_table" "training_private_b_rt" {
  vpc_id = aws_vpc.training.id

  tags = merge({ Name = "training_private_b_rt" }, local.tags)
}

resource "aws_route_table_association" "training_private_b_rt" {
  route_table_id = aws_route_table.training_private_b_rt.id
  subnet_id      = aws_subnet.training_private_b.id
}

resource "aws_subnet" "training_public_a" {
  vpc_id                  = aws_vpc.training.id
  cidr_block              = local.public_subnet_a_cidr_block
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = true

  tags = merge({ Name = "training_public_a" }, local.tags)
}

resource "aws_route_table" "training_public_a_rt" {
  vpc_id = aws_vpc.training.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.training-igw.id
  }

  tags = merge({ Name = "training_public_a_rt" }, local.tags)
}

resource "aws_route_table_association" "training_public_a_rt" {
  route_table_id = aws_route_table.training_public_a_rt.id
  subnet_id      = aws_subnet.training_public_a.id
} 