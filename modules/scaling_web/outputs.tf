
/*
output "webapp_public_ips" {
  value = aws_instance.web_app[*].public_ip
}

output "webapp_url" {
  # value = "http://${data.aws_lb.this.dns_name}/${var.name_prefix}"
  value = var.alb_listener_arn != "" ? "http://${data.aws_lb.this[0].dns_name}/${var.name_prefix}" : ""
}
*/

output "web_listener_arn" {
  description = "ARN of the ALB Listener for the web application"
  value = aws_lb_listener.web_listener.arn
}

output "lb_arn" {
  description = "ARN of the ALB  for the web application"
  value = aws_lb.web_alb.arn
}

output "web_alb_tg_arn" {
  description = "ARN of the ALB Target Group for the web application"
  value = aws_lb_target_group.web_alb_tg.arn
}

output "web_alb_dns" {
  description = "DNS name of the ALB for the web application"
  value = aws_lb.web_alb.dns_name
}

output "webapp_url" {
  # value = "http://${data.aws_lb.this.dns_name}/${var.name_prefix}"
  value = "http://${aws_lb.web_alb.dns_name}/${local.name_prefix}"
}