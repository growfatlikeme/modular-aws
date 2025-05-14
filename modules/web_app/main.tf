resource "null_resource" "wait_for_key_pair" {
  triggers = {
    key_name = var.key_name
  }
}

resource "aws_instance" "web_app" {
  for_each = local.subnet_map

  ami                         = data.aws_ami.amazon2023.id 
  instance_type               = var.instance_type
  key_name                    = var.key_name  # Use the key name passed as a variable
  vpc_security_group_ids      = [var.sg_web_app_id] # Use the security group ID passed as a variable
  subnet_id                   = each.value
  associate_public_ip_address = true
  user_data = templatefile("${path.module}/init-script.sh", {file_content = "webapp-#${tonumber(each.key) + 1}"})

  user_data_replace_on_change = true # this forces instance to be recreated upon update of user data contents
 
 
  tags = {
    Name = "${local.name_prefix}-web_app-${tonumber(each.key) + 1}"
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
