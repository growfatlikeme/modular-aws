
# Get web app instance information
output "web_app_instance_ip" {
  description = "Public IP addresses of the web_app instances"
  value = {
    for k, instance in aws_instance.web_app : k => instance.public_ip
  }
  }


output "web_app_instance_dns" {
  description = "Public DNS names of the web_app instances"
  value = {
    for k, instance in aws_instance.web_app : k => instance.public_dns
  }
  depends_on = [aws_instance.web_app]
  }


