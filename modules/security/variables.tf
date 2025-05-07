#variables specific to network module depending on tfvars invoked, may override

variable "name" {
  type = string
  description = "Ownership of resources"
}

variable "environment" {
  type = string
  description = "Environment type (dev, staging, prod)"
}

variable "vpc_id" {
  type = string
  description = "VPC ID"
}
variable "public_subnet_ids" {
  type = list(string)
  description = "Public subnet IDs"
}
variable "private_subnet_ids" {
  type = list(string)
  description = "Private subnet IDs"
}