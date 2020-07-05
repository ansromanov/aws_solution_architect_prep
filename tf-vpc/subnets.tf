resource "aws_subnet" "training_private" {
  vpc_id                  = aws_vpc.training.id
  cidr_block              = local.private_subnet_cidr_block
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = false
  tags                    = merge({ Name = "training_private" }, local.tags)
}

resource "aws_route_table" "training_private_rt" {
  vpc_id = aws_vpc.training.id

  tags = merge({ Name = "training_private_rt" }, local.tags)
}

resource "aws_route_table_association" "training_private_rt" {
  route_table_id = aws_route_table.training_private_rt.id
  subnet_id      = aws_subnet.training_private.id
}

resource "aws_subnet" "training_public" {
  vpc_id                  = aws_vpc.training.id
  cidr_block              = local.public_subnet_cidr_block
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = true

  tags = merge({ Name = "training_public" }, local.tags)
}

resource "aws_route_table" "training_public_rt" {
  vpc_id = aws_vpc.training.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.training-igw.id
  }

  tags = merge({ Name = "training_public_rt" }, local.tags)
}

resource "aws_route_table_association" "training_public_rt" {
  route_table_id = aws_route_table.training_public_rt.id
  subnet_id      = aws_subnet.training_public.id
}