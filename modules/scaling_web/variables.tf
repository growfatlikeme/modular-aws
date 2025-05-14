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

variable "alb_sg_id" {
  type = string
  description = "Security group ID for the web app instance"      
  
}

variable "sg_web_app_id" {
  type = string
  description = "Security group ID for the web app instance"      
  
}
/*
variable "public_subnet" {
 description = "Choice of deploying to public or private subnet"
 type        = bool
}
*/

variable "public_subnet_ids" {
  type =  list(string)
  description = "Public subnet IDs"
}

variable "private_subnet_ids" {
  type =  list(string)
  description = "Public subnet IDs"
}

variable "key_name" {
  description = "Name of the SSH key pair to use for instances"
  type        = string
}

/*
variable "alb_listener_arn" {
  description = "ALB listener Arn"
  type        = string
  default     = ""
}
*/