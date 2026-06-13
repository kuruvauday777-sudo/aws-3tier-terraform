resource "aws_security_group" "web_sg" {

  name        = "web-sg"
  description = "Web Tier Security Group"

  vpc_id = aws_vpc.main.id

  ingress {

    description = "HTTP"

    from_port = 80
    to_port   = 80

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {

    description = "HTTPS"

    from_port = 443
    to_port   = 443

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {

    description = "SSH"

    from_port = 22
    to_port   = 22

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

resource "aws_security_group" "app_sg" {

  name        = "app-sg"
  description = "Application Tier Security Group"

  vpc_id = aws_vpc.main.id

  ingress {

    description = "NodeJS"

    from_port = 3001
    to_port   = 3001

    protocol = "tcp"

    security_groups = [
      aws_security_group.web_sg.id
    ]
  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app-sg"
  }
}

resource "aws_security_group" "db_sg" {

  name        = "db-sg"
  description = "Database Security Group"

  vpc_id = aws_vpc.main.id

  ingress {

    description = "MySQL"

    from_port = 3306
    to_port   = 3306

    protocol = "tcp"

    security_groups = [
      aws_security_group.app_sg.id
    ]
  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-sg"
  }
}

