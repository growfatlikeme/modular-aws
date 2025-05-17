################################################################################
# Network Infrastructure Outputs inside Modules
################################################################################

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.my_vpc.id
}

data "aws_nat_gateways" "existing_nat_gw" {
  filter {
    name   = "state"
    values = ["available"]
  }
}

#get ngw id or return null if not found
output "nat_gateway_id" {
  value = length(data.aws_nat_gateways.existing_nat_gw.ids) > 0 ? data.aws_nat_gateways.existing_nat_gw.ids[0] : "[]"
}



# check public subnets info
output "public_subnet_ids" {
  description = "IDs of the public subnets"
 value       = [for subnet in aws_subnet.public_subnets : subnet.id]
}

output "subnet_names_public" {
  value = {
    for subnet in aws_subnet.public_subnets :
    subnet.id => subnet.tags["Name"]
  }
}

# check private subnets info
output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = [for subnet in aws_subnet.private_subnets : subnet.id]
}

output "subnet_names_private" {
  value = {
    for subnet in aws_subnet.private_subnets :
    subnet.id => subnet.tags["Name"]
  }
}

output "database_subnet_ids" {
  description = "IDs of the database subnets"
  value       = [for subnet in aws_subnet.database_subnets : subnet.id]
}

output "subnet_names_database" {
  description = "Names of the database subnets"
  value = {
    for subnet in aws_subnet.database_subnets : 
    subnet.id => subnet.tags["Name"]
  }
}

  
  output "database_subnet_group_name" {
  description = "Name of the database subnet group"
  value = aws_db_subnet_group.database.name
}
