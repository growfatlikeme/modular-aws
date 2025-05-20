resource "null_resource" "wait_for_key_pair" {
  triggers = {
    key_name = var.key_name
  }
}

resource "aws_instance" "ec2_public" {   #create only one instance

  ami                         = data.aws_ami.amazon2023.id 
  instance_type               = var.instance_type
  key_name                    = var.key_name  # Use the key name passed as a variable
  vpc_security_group_ids      = [var.sg_bastion_id] # Use the security group ID passed as a variable
  subnet_id                   = element(var.public_subnet_ids, 0) # Use the public subnet ID passed as a variable
  associate_public_ip_address = true
  user_data = <<-EOF
            #!/bin/bash
            echo "export AWS_DEFAULT_REGION=${var.region}" >> /etc/profile
            mkdir -p /home/ec2-user/.aws
            echo "[default]" > /home/ec2-user/.aws/config
            echo "region = ${var.region}" >> /home/ec2-user/.aws/config
            chown -R ec2-user:ec2-user /home/ec2-user/.aws
            while [ ! -e /dev/xvdf ]; do
              echo "Waiting for EBS volume to be attached..."
              sleep 10
            done

            sudo mkfs -t ext4 /dev/xvdf
            sudo mkdir /mydata
            sudo mount /dev/xvdf /mydata/
            EOF

  user_data_replace_on_change = true # this forces instance to be recreated upon update of user data contents
 
 
  tags = {
    Name = "${local.name_prefix}-ec2_public"
  }


  lifecycle {
    create_before_destroy = true
  }
  
  depends_on = [null_resource.wait_for_key_pair]

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
