#variables specific to network module depending on tfvars invoked, may override

variable "name" {
  type = string
  description = "Ownership of resources"
}

variable "environment" {
  type = string
  description = "Environment type (dev, staging, prod)"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "vpc_id" {
  type = string
  description = "value of vpc id"
}

variable "sg_bastion_id" {
  type = string
  description = "Security group ID for the web app instance"      
  
}

variable "public_subnet_ids" {
  type =  list(string)
  description = "Public subnet IDs"
  
}

variable "key_name" {
  description = "Name of the SSH key pair to use for instances"
  type        = string
}

variable "region" {
  type = string
  description = "AWS region"
  
}