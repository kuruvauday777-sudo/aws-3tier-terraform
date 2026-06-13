resource "aws_lb" "web_alb" {

  name     = "web-alb"
  internal = false

  load_balancer_type = "application"

  security_groups = [
    aws_security_group.web_sg.id
  ]

  subnets = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]

  tags = {
    Name = "web-alb"
  }
}

resource "aws_lb_target_group" "web_tg" {

  name = "web-tg"

  port     = 80
  protocol = "HTTP"

  vpc_id = aws_vpc.main.id

  health_check {

    path = "/"

    port = "traffic-port"

    protocol = "HTTP"
  }
}

resource "aws_lb_listener" "web_listener" {

  load_balancer_arn = aws_lb.web_alb.arn

  port     = 80
  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

resource "aws_lb" "app_alb" {

  name = "app-alb"

  internal = true

  load_balancer_type = "application"

  security_groups = [
    aws_security_group.app_sg.id
  ]

  subnets = [
    aws_subnet.app_1.id,
    aws_subnet.app_2.id
  ]

  tags = {
    Name = "app-alb"
  }
}

resource "aws_lb_target_group" "app_tg" {

  name = "app-tg"

  port = 3001

  protocol = "HTTP"

  vpc_id = aws_vpc.main.id

  health_check {

    path = "/"

    protocol = "HTTP"

    port = "traffic-port"
  }
}

resource "aws_lb_listener" "app_listener" {

  load_balancer_arn = aws_lb.app_alb.arn

  port = 3001

  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

