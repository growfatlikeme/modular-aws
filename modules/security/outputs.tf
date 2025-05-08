# Outputs for the security module

output "sg_bastion_id" {  # Changed from sg-bastion_id to sg_bastion_id
  description = "The ID of the bastion security group"
  value       = aws_security_group.bastion_allow_ssh.id
}


output "key_pair_name" {
  description = "Name of the created key pair"
  value       = aws_key_pair.bastion_key.key_name
}
