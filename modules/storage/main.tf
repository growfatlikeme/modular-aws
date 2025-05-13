
# This module creates an S3 bucket for storing Terraform state files.
resource "aws_s3_bucket" "sample_bucket" {  
  bucket = "${local.name_prefix}-tf-bucket-for-fun"

  
}

# Enable versioning on the S3 bucket
resource "aws_s3_bucket_versioning" "sample_bucket_versioning" {
  bucket = aws_s3_bucket.sample_bucket.id
  
  versioning_configuration {
    status = "Suspended"  # Set to "Enabled" if you want to enable versioning
  }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "sample_bucket_encryption" {
  bucket = aws_s3_bucket.sample_bucket.id

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
resource "aws_s3_bucket_public_access_block" "sample_bucket_public_access" {
  bucket = aws_s3_bucket.sample_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}