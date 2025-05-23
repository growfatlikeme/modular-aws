variable "name" {
  type = string
  description = "Ownership of resources"
}

variable "environment" {
  type = string
  description = "Environment type (dev, staging, prod)"
}

variable "bucket_name" {
  type = string
  description = "The name of the S3 bucket"
  
}

