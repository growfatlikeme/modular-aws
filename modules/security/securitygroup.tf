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

resource "aws_security_group" "web_app_allow_tcp80_alb" {
  name        = "${local.name_prefix}-sg-webapp"
  description = "Allow HTTP inbound from LB and all outbound"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow HTTP from ALB only"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]  # Allow traffic from the ALB security group
  }

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  lifecycle {
    prevent_destroy = false  # Ensures Terraform allows deletion
  }

  tags = {
    Name = "${local.name_prefix}-webapp_tcp80_443"
  }
}

resource "aws_security_group" "web_app_allow_ssh_from_bastion" {
  name        = "${local.name_prefix}-sg-bastion-to-webapp"
  description = "Allow SSH inbound from bastion and all outbound"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow SSH from bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_allow_ssh.id]  # Allow traffic from the bastion security group
  }

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  lifecycle {
    prevent_destroy = false  # Ensures Terraform allows deletion
  }

  tags = {
    Name = "${local.name_prefix}-sg-bastion-to-webapp"
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "${local.name_prefix}-sg-alb"
  description = "Allow HTTP traffic from anywhere"
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

    tags = {
    Name = "${local.name_prefix}-sg-http_https_alb"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "${local.name_prefix}-rds-sg"
  description = "Allow DB traffic from bastion sources"
  vpc_id      = var.vpc_id

  # Example: Allow connections from internal application instances
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.bastion_allow_ssh.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}