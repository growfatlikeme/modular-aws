# Outputs for the security module

output "sg_bastion_id" {  # Changed from sg-bastion_id to sg_bastion_id
  description = "The ID of the bastion security group"
  value       = aws_security_group.bastion_allow_ssh.id
}

output "web_app_allow_ssh_from_bastion_id" {
  description = "The ID of the web app security group allowing SSH from bastion"
  value       = aws_security_group.web_app_allow_ssh_from_bastion.id
  
}

output "key_pair_name" {
  description = "Name of the created key pair"
  value       = aws_key_pair.bastion_key.key_name
}

output "private_key_name" {
  description = "Name of the created key pair"
  value       = aws_key_pair.private_key.key_name
}

output "sg_web_app_id" {
  description = "The ID of the web app security group"
  value       = aws_security_group.web_app_allow_tcp80_alb.id
  
}

output "alb_sg_id" {
  description = "The ID of the web app security group"
  value       = aws_security_group.alb_sg.id
  
}