################################################################################
# Network Infrastructure Outputs at root level
################################################################################

# Storage outputs
output "tf_bucket_name" {
  description = "The S3 bucket name used to store the Terraform state"
  value       = module.storage.tf_bucket_name
}

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

# Compute outputs
output "bastion_instance_ips" {
  description = "Public IP addresses of the bastion instances"
  value       = module.compute.bastion_instance_ip
}

output "bastion_instance_dns" {
  description = "Public DNS names of the bastion instances"
  value       = module.compute.bastion_instance_dns
}

# Application outputs
output "cart_topic_arns" {
  description = "The ARNs of the SNS topics"
  value       = module.app_topics.cart_topic_arns
}
