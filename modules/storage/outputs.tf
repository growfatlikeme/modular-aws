################################################################################
# Outputs of the Storage Module
################################################################################

output "tf_bucket_name" {
  value = aws_s3_bucket.s3bucket.bucket
  description = "The name of the S3 bucket"
}

output "tf_bucket_arn" {
  value = aws_s3_bucket.s3bucket.arn
  description = "The ARN of the S3 bucket"
  
}

output "tf_bucket_domain_name" {
  value = aws_s3_bucket.s3bucket.bucket_domain_name
  description = "The domain name of the S3 bucket"
  

}

output "tf_bucket_website_url" {
  value = aws_s3_bucket_website_configuration.static_site.website_endpoint
  description = "The website URL of the S3 bucket"

}

output "tf_bucket_hosted_zone_id" {
  value = aws_s3_bucket.s3bucket.hosted_zone_id
  description = "The hosted zone ID of the S3 bucket"
  
}

output "website_configuration_domain" {
  value = aws_s3_bucket_website_configuration.static_site.website_domain
  description = "The website configuration of the S3 bucket"
  
}

output "public_access_block_id" {
  value = aws_s3_bucket_public_access_block.allow_public_access.id
  description = "The public access block configuration of the S3 bucket"
  
}