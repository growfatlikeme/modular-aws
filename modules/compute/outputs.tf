################################################################################
# Compute Instance Outputs inside Modules
################################################################################
/*
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.my_vpc.id
}
*/
/*

# Get Bastion instance information
output "bastion_instance_ip" {
  description = "Public IP addresses of the bastion instances"
  value = {
    for k, instance in aws_instance.bastion : k => instance.public_ip
  }
  }


output "bastion_instance_dns" {
  description = "Public DNS names of the bastion instances"
  value = {
    for k, instance in aws_instance.bastion : k => instance.public_dns
  }
  depends_on = [aws_instance.bastion]
  }


*/