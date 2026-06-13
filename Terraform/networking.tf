data "aws_availability_zones" "available" {}
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {

  allocation_id = aws_eip.nat_eip.id

  subnet_id = aws_subnet.public_1.id

  tags = {
    Name = "book-review-nat"
  }

  depends_on = [
    aws_internet_gateway.igw
  ]
}

resource "aws_route_table" "public_rt" {

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_assoc_1" {

  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_assoc_2" {

  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {

  vpc_id = aws_vpc.main.id

  route {

    cidr_block = "0.0.0.0/0"

    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "app_assoc_1" {

  subnet_id = aws_subnet.app_1.id

  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "app_assoc_2" {

  subnet_id = aws_subnet.app_2.id

  route_table_id = aws_route_table.private_rt.id
}


resource "aws_route_table_association" "db_assoc_1" {

  subnet_id = aws_subnet.db_1.id

  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "db_assoc_2" {

  subnet_id = aws_subnet.db_2.id

  route_table_id = aws_route_table.private_rt.id
}

