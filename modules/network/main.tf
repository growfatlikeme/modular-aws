#create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.myvpc_cidr

  tags = {
    Name = "${local.name_prefix}-vpc"
  }
}
