################################################################################
# Outputs of the Storage Module
################################################################################

output "tfstate_bucket_name" {
  value = aws_s3_bucket.terraform_state.bucket
}