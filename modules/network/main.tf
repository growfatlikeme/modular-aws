#create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.myvpc_cidr
  enable_dns_support   = true   # Enables DNS resolution
  enable_dns_hostnames = true   # Enables public DNS hostnames

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

#create igw
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
 
  tags = {
    Name = "${local.name_prefix}-IGW"
  }
}

#Create public route
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id
 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
 
  tags = {
    Name = "${local.name_prefix}-Public-Route-Table"
  }
}

#associate public subnets with public route
resource "aws_route_table_association" "public_subnet_asso" {
  for_each = aws_subnet.public_subnets
 
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id
}

#generate EIP for nat GW
resource "aws_eip" "nat" {
  domain = "vpc"
}

#Create one NAT Gateway in the first public subnet using the allocated Elastic IP
resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = values(aws_subnet.public_subnets)[0].id
    
  tags = {
    Name = "${local.name_prefix}-natgw"
  }
}

#Create private route
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my_vpc.id
 
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }
 
  tags = {
    Name = "${local.name_prefix}-Private-Route-Table"
  }
}

#associate private subnets with private route
resource "aws_route_table_association" "private_subnet_asso" {
  for_each = aws_subnet.private_subnets
  
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_rt.id
}

#associate database subnets with private route
resource "aws_route_table_association" "database_subnet_asso" {
  for_each = aws_subnet.database_subnets
  
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_rt.id
}