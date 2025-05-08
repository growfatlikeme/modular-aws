
# This module creates an S3 bucket for storing Terraform state files.
resource "aws_s3_bucket" "terraform_state" {  
  bucket = "${local.name_prefix}-terraform-state"

  
}

# Enable versioning on the S3 bucket
resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  
  versioning_configuration {
    status = "Suspended"  # Set to "Enabled" if you want to enable versioning
  }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_encryption" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }

  
  # uncomment this block to use KMS encryption via AWS Key Management Service (KMS)
   # apply_server_side_encryption_by_default {
    #  sse_algorithm     = "aws:kms"
    #  kms_master_key_id = "arn:aws:kms:region:account-id:key/key-id"
   # }
   
  }
}

# Block public access
resource "aws_s3_bucket_public_access_block" "terraform_state_public_access" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}