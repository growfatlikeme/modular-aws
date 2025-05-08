# This file contains the configuration for creating a public EC2 instance in AWS using Terraform.

/*
resource "aws_instance" "public" {
  ami                         = data.aws_ami.amazon2023.id 
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnets[0].id  # Use the first public subnet directly
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]
 #key_name      = aws_key_pair.bastion_key.key_name  # Link key pair
  user_data_replace_on_change = true # this forces instance to be recreated upon update of user data contents

  #depends_on = [aws_subnet.public_subnets, aws_security_group.allow_ssh]

    lifecycle {
    create_before_destroy = true  # Ensures a new instance is created first before old one is removed
  }

  tags = {
    Name = "${local.name_prefix}-bastion"
  }
}


locals {
  random_subnet = element(shuffle(data.aws_subnets.public_subnets.ids), 0)      #for random subnet selection
}
*/


# This file contains the configuration for creating a public EC2 instance in AWS using Terraform.

# Define local variables for the module
# In modules/compute/main.tf
resource "aws_instance" "bastion" {
  for_each = local.subnet_map

  ami                         = data.aws_ami.amazon2023.id 
  instance_type               = var.instance_type
  key_name                    = var.key_name  # Use the key name passed as a variable
  vpc_security_group_ids      = [var.sg_bastion_id]
  subnet_id                   = each.value
  associate_public_ip_address = true
 
 
 tags = {
    Name = "${local.name_prefix}-Bastion-${tonumber(each.key) + 1}"
  }


  user_data_replace_on_change = true

  lifecycle {
    create_before_destroy = true
  }
  
  timeouts {
    create = "5m"
    update = "5m"
    delete = "5m"
  }
}


# This resource is used to create a default EC2 instance metadata options
resource "aws_ec2_instance_metadata_defaults" "enforce-imdsv2" {
  http_tokens = "optional"
}
