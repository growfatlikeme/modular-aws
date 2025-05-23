/*
resource "aws_launch_template" "web_server_lt" {
  name                   = "${local.name_prefix}-launch-template"
  description            = "private web app launch template"
  image_id               = data.aws_ami.amazon2023.id
  instance_type          = var.instance_type
  key_name               = var.key_name

  # Metadata Options
  metadata_options {
    http_tokens = "optional"
  }

  # Security Groups
  network_interfaces {
    associate_public_ip_address = false
    security_groups = [var.sg_web_app_id, var.sg_ssh_priv_from_bastion_id] # Use the security group ID passed as a variable
  }

    # User data script that sets the instance name
   user_data = base64encode(templatefile("${path.module}/init-script.tpl", {
    name_prefix = local.name_prefix
  }))

  tags = {
    Name = "${local.name_prefix}-webapp-template"
  }
}

*/