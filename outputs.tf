################################################################################
# Network Infrastructure Outputs at root level
################################################################################

output "tfstate_bucket_id" {
  description = " The s3 bucket id used to store the terraform state"
  value       = module.storage.tfstate_bucket_id
}

output "vpc_id" {  
  value       = module.network.vpc_id
  description = "The ID of the VPC"
}

output "nat_gateway_id" {
  value = module.network.nat_gateway_id
  description = "The ID of the natgw"
}

output "sg_bastion_id" {
  description = "ID of the bastion security group"
  value       = module.security.sg_bastion_id  
}

output "bastion_instance_ips" {
  description = "Public IP addresses of the bastion instances"
  value       = module.compute.bastion_instance_ip
}

output "bastion_instance_dns" {
  description = "Public DNS names of the bastion instances"
  value       = module.compute.bastion_instance_dns
}

output "subnet_names_public" {
  value = module.network.subnet_names_public
  description = "The names of the public subnets"
}
output "subnet_names_private" {
  value = module.network.subnet_names_private
  description = "The names of the private subnets"
}
output "public_subnet_ids" {
  value = module.network.public_subnet_ids
  description = "The IDs of the public subnets"
}
output "private_subnet_ids" {
  value = module.network.private_subnet_ids
  description = "The IDs of the private subnets"
}


/*
output "bastion_instance_ami" {
  value = module.compute.bastion_instance_ami
  description = "The AMI of the bastion instance"
}
output "bastion_instance_type" {
  value = module.compute.bastion_instance_type
  description = "The instance type of the bastion instance"
}
output "bastion_instance_key_name" {
  value = module.compute.bastion_instance_key_name
  description = "The key name of the bastion instance"
}
output "bastion_instance_security_groups" {
  value = module.compute.bastion_instance_security_groups
  description = "The security groups of the bastion instance"
}
output "bastion_instance_subnet_id" {
  value = module.compute.bastion_instance_subnet_id
  description = "The subnet ID of the bastion instance"
}
output "bastion_instance_availability_zone" {
  value = module.compute.bastion_instance_availability_zone
  description = "The availability zone of the bastion instance"
}
*/