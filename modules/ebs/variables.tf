variable "name" {
  type = string
  description = "Ownership of resources"
}

variable "environment" {
  type = string
  description = "Environment type (dev, staging, prod)"
}

variable "azs" {
  type = string
  description = "List of public subnet IDs"
  
}

variable "instance_ids" {
  type = string
  description = "List of instance IDs to attach the EBS volume to"
  
}

