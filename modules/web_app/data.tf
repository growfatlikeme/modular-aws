#query to read latest Amazon Linux 2023 AMI
data "aws_ami" "amazon2023" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-kernel-6.1-x86_64"]
  }
  owners = ["amazon"]
}

/*
data "aws_subnets" "public_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]  # Use VPC ID passed as a variable
  }
  
  filter {
    name   = "map-public-ip-on-launch"
    values = ["true"]                       # Ensures only public subnets are returned
  }
}
*/