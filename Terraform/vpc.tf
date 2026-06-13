resource "aws_vpc" "main" {

  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "book-review-vpc"
  }
}
resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "book-review-igw"
  }
}

resource "aws_subnet" "public_1" {

  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  availability_zone = data.aws_availability_zones.available.names[0]

  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_2" {

  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  availability_zone = data.aws_availability_zones.available.names[1]

  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "app_1" {

  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.11.0/24"

  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "app-subnet-1"
  }
}

resource "aws_subnet" "app_2" {

  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.12.0/24"

  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "app-subnet-2"
  }
}

resource "aws_subnet" "db_1" {

  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.21.0/24"

  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "db-subnet-1"
  }
}

resource "aws_subnet" "db_2" {

  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.22.0/24"

  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "db-subnet-2"
  }
}

