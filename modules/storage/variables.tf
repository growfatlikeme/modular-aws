variable "name" {
  type = string
  description = "Ownership of resources"
}

variable "environment" {
  type = string
  description = "Environment type (dev, staging, prod)"
}


variable "s3_web_policy" {
  type = string
  description = "S3 bucket policy for web access"
  
}