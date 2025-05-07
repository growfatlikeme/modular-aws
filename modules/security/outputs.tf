# Outputs for the security module

output "sg_bastion_id" {  # Changed from sg-bastion_id to sg_bastion_id
  description = "The ID of the bastion security group"
  value       = aws_security_group.bastion_allow_ssh.id
}