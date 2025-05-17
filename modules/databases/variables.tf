#variables specific to network module depending on tfvars invoked, may override

variable "name" {
  type = string
  description = "Ownership of resources"
}

variable "environment" {
  type = string
  description = "Environment type (dev, staging, prod)"
}

variable "database_subnet_group_name" {
  description = "Name of the database subnet group"
  type        = string
}


variable "rds_sg_id" {
  type = list(string)
  description = "RDS security group ID"
}