
/*
output "webapp_public_ips" {
  value = aws_instance.web_app[*].public_ip
}

output "webapp_url" {
  # value = "http://${data.aws_lb.this.dns_name}/${var.name_prefix}"
  value = var.alb_listener_arn != "" ? "http://${data.aws_lb.this[0].dns_name}/${var.name_prefix}" : ""
}
*/

/*
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

output "webapp_url_http" {
  # value = "http://${data.aws_lb.this.dns_name}/${var.name_prefix}"
  value = "http://${local.domain_name}/index.html"
}

output "webapp_url_https" {
  # value = "http://${data.aws_lb.this.dns_name}/${var.name_prefix}"
  value = "https://${local.domain_name}/index.html"
}

output "alt_weblink" {
  description = "ALB DNS web access"
   value = "https://${aws_lb.web_alb.dns_name}/index.html"
  
}

*/
