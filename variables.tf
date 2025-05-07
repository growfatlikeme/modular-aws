#If terraform apply is run with the staging.tfvars file, the values in the variables.tf file will be overridden by the values in the staging.tfvars file.
#This file defines globals variables to be used regardless of environment
/*
variable "name" {
    type = string
    description = "tag my resources"
    default     = "estee"
} 

variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources"
}

variable "environment" {
  type        = string
  description = "Environment type (dev, staging, prod)"
}


variable "myvpc_cidr" {
 type        = string
 description = "VPC CIDR range"
}

variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
}
 
variable "private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
}

variable "database_subnet_cidrs" {
 type        = list(string)
 description = "Database Subnet CIDR values"
}

variable "azs" {
 type        = list(string)
 description = "Availability Zones"
}

variable "tagging" {
  type        = string
  description = "Tagging my resources"
}

*/

variable "aws_region" {
  type    = string
}

variable "myvpc_cidr" {
  type = string
}

variable "name" {
  type = string
}

variable "environment" {
  type = string
}
