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
    security_groups = [var.sg_web_app_id] # Use the security group ID passed as a variable
  }

  user_data = base64encode(file("${path.module}/init-script.sh"))

  tags = {
    Name = "${local.name_prefix}-web_app"
  }
}