output "vpc_id" {

  value = aws_vpc.main.id
}

output "web_alb_dns" {

  value = aws_lb.web_alb.dns_name
}

output "internal_alb_dns" {

  value = aws_lb.app_alb.dns_name
}

output "db_endpoint" {

  value = aws_db_instance.mysql.endpoint
}
