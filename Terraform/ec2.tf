data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "web" {

  count = 2

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name = "key"
  subnet_id = element([
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ], count.index)

  vpc_security_group_ids = [
    aws_security_group.web_sg.id
  ]

  associate_public_ip_address = true

  tags = {
    Name = "web-${count.index + 1}"
  }
}


resource "aws_lb_target_group_attachment" "web_attachment" {

  count = 2

  target_group_arn = aws_lb_target_group.web_tg.arn

  target_id = aws_instance.web[count.index].id

  port = 80
}

resource "aws_instance" "app" {

  count = 2

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name = "key"
  subnet_id = element([
    aws_subnet.app_1.id,
    aws_subnet.app_2.id
  ], count.index)

  vpc_security_group_ids = [
    aws_security_group.app_sg.id
  ]

  associate_public_ip_address = false

  tags = {
    Name = "app-${count.index + 1}"
  }
}

resource "aws_lb_target_group_attachment" "app_attachment" {

  count = 2

  target_group_arn = aws_lb_target_group.app_tg.arn

  target_id = aws_instance.app[count.index].id

  port = 3001
}

