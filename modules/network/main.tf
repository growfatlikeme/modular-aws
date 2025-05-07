#create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.myvpc_cidr

  tags = {
    Name = "${local.name_prefix}-vpc"
  }
}

data "aws_availability_zones" "available" {}

#create subnets for each availability zone, limited by the number of elements of assigned cidr in tfvars
resource "aws_subnet" "public_subnets" {
  for_each = {
    for i, az in var.azs : i => {
      az   = az
      cidr = var.public_subnet_cidrs[i]
    }
    if i < length(var.public_subnet_cidrs)
  }
  
  vpc_id                  = aws_vpc.my_vpc.id
  map_public_ip_on_launch = true
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  
  tags = {
    Name = "${local.name_prefix}-public-subnet-${each.key + 1}"
  }
}
 
#create private subnets using for_each
resource "aws_subnet" "private_subnets" {
  for_each = {
    for i, az in var.azs : i => {
      az   = az
      cidr = var.private_subnet_cidrs[i]
    }
    if i < length(var.private_subnet_cidrs)
  }
  
  vpc_id                  = aws_vpc.my_vpc.id
  map_public_ip_on_launch = false
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  
  tags = {
    Name = "${local.name_prefix}-private-subnet-${each.key + 1}"
  }
}

#create database subnets using for_each
resource "aws_subnet" "database_subnets" {
  for_each = {
    for i, az in var.azs : i => {
      az   = az
      cidr = var.database_subnet_cidrs[i]
    }
    if i < length(var.database_subnet_cidrs)
  }
  
  vpc_id                  = aws_vpc.my_vpc.id
  map_public_ip_on_launch = false
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  
  tags = {
    Name = "${local.name_prefix}-database-subnet-${each.key + 1}"
  }
}