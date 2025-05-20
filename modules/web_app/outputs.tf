
# Get web app instance information
output "ec2_public_instance_ip" {
  description = "Public IP addresses of the ec2_public instances"
  value = aws_instance.ec2_public.public_ip
  }


output "ec2_public_instance_dns" {
  description = "Public DNS names of the ec2_public instances"
  value = aws_instance.ec2_public.public_dns
  depends_on = [aws_instance.ec2_public]
  }


output "ec2_public_instance_id" {
  description = "id of the ec2_public instances"
  value = aws_instance.ec2_public.id
  }



output "ec2_public_instance_availability_zone" {
  description = "Availability zone of the ec2_public instances"
  value = aws_instance.ec2_public.availability_zone
  }
  
