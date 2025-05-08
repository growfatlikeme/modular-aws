################################################################################
# Outputs of the Storage Module
################################################################################

output "tfstate_bucket_id" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.terraform_state.bucket.id
}