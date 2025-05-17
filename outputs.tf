################################################################################
# Network Infrastructure Outputs at root level
################################################################################
/*
# Storage outputs
output "tf_bucket_name" {
  description = "The S3 bucket name used to store the Terraform state"
  value       = module.storage.tf_bucket_name
}
*/
# Network outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.network.vpc_id
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = module.network.nat_gateway_id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = module.network.private_subnet_ids
}

output "subnet_names_public" {
  description = "The names of the public subnets"
  value       = module.network.subnet_names_public
}

output "subnet_names_private" {
  description = "The names of the private subnets"
  value       = module.network.subnet_names_private
}

# Security outputs
output "sg_bastion_id" {
  description = "ID of the bastion security group"
  value       = module.security.sg_bastion_id
}

output "bastion_key_pair_name" {
  description = "Name of the bastion key pair"
  value       = module.security.key_pair_name
  
}

output "private_key_name" {
  description = "Name of the created key pair"
  value       = module.security.private_key_name
}

output "sg_web_app_id" {
  description = "The ID of the web app security group"
  value       = module.security.sg_web_app_id
  
}

output "alb_sg_id" {
  description = "The ID of the ALB security group"
  value       = module.security.alb_sg_id
  
}

output "web_app_allow_ssh_from_bastion_id" {
  description = "The ID of the web app security group allowing SSH from bastion"
  value       = module.security.web_app_allow_ssh_from_bastion_id
  
}

# Scaling Module outputs

output "web_listener_arn" {
  description = "ARN of the ALB Listener for the web application"
  value = module.scaling_web.web_listener_arn
}

output "lb_arn" {
  description = "ARN of the ALB  for the web application"
  value = module.scaling_web.lb_arn
}

output "web_alb_tg_arn" {
  description = "ARN of the ALB Target Group for the web application"
  value = module.scaling_web.web_alb_tg_arn
}

output "web_alb_dns" {
  description = "DNS name of the ALB for the web application"
  value = module.scaling_web.web_alb_dns
}

output "webapp_url_http" {
  description = "URL of the web application non-SSL"
  value = module.scaling_web.webapp_url_http
}

output "alt_weblink" {
  description = "Accessing web application using ALB DNS"
  value = module.scaling_web.alt_weblink
}

output "webapp_url_https" {
  description = "URL of the web application SSL"
  value = module.scaling_web.webapp_url_https
}

# Compute outputs
output "bastion_instance_ips" {
  description = "Public IP addresses of the bastion instances"
  value       = module.compute.bastion_instance_ip
}

output "bastion_instance_dns" {
  description = "Public DNS names of the bastion instances"
  value       = module.compute.bastion_instance_dns
}

/*
# WebApp outputs
output "web_app_instance_ips" {
  description = "Public IP addresses of the web app instances"
  value       = module.web_app.web_app_instance_ip
}

output "web_app_instance_dns" {
  description = "Public DNS names of the web app instances"
  value       = module.web_app.web_app_instance_dns
}
*/
/*
# Application outputs
output "cart_topic_arns" {
  description = "The ARNs of the SNS topics"
  value       = module.app_topics.cart_topic_arns
}
*/

# IAM outputs
output "data_policy_sample" {
  description = "IAM Policy Document from AWS"
  value       = module.iam.data_policy_sample
  
}

output "instance_profile_name" {
  description = "IAM Instance Profile Name"
  value       = module.iam.instance_profile_name
  
}	