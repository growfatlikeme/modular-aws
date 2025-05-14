resource "aws_security_group" "bastion_allow_ssh" {
  name        = "${local.name_prefix}-sg-bastion"
  description = "Allow SSH inbound and all outbound"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    prevent_destroy = false  # Ensures Terraform allows deletion
  }

  tags = {
    Name = "${local.name_prefix}-bastion_ssh"
  }
}

resource "aws_security_group" "web_app_allow_tcp80_443" {
  name        = "${local.name_prefix}-sg-webapp"
  description = "Allow HTTP and HTTPS inbound and all outbound"
  vpc_id      = var.vpc_id

  ingress {
   description = "Allow HTTP from anywhere"
   from_port        = 80
   to_port          = 80
   protocol         = "tcp"
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]

  }

  ingress {
   description = "Allow HTTPS from anywhere"
   from_port        = 443
   to_port          = 443
   protocol         = "tcp"
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]

  }

  egress {
    description = "Allow all outbound traffic"
    from_port        = 0
   to_port          = 0
   protocol         = "-1"
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]

  }

  lifecycle {
    prevent_destroy = true  # Ensures Terraform allows deletion
  }

  tags = {
    Name = "${local.name_prefix}-webapp_tcp80_443"
  }
}
