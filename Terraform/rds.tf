resource "aws_db_subnet_group" "db_subnet_group" {

  name = "book-review-db-subnet-group"

  subnet_ids = [
    aws_subnet.db_1.id,
    aws_subnet.db_2.id
  ]

  tags = {
    Name = "db-subnet-group"
  }
}

resource "aws_db_instance" "mysql" {

  identifier = "book-review-mysql"

  engine         = "mysql"
  engine_version = "8.0"

  instance_class = "db.t3.micro"

  allocated_storage = 20

  storage_type = "gp3"

  username = "admin"

  password = var.db_password

  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name

  vpc_security_group_ids = [
    aws_security_group.db_sg.id
  ]

  publicly_accessible = false

  multi_az = true

  skip_final_snapshot = true

  tags = {
    Name = "primary-mysql"
  }
}
