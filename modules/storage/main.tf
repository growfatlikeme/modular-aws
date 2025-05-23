
# This module creates an S3 bucket for hosting a static website.
# For policy document defined for this bucket, see the IAM module.
resource "aws_s3_bucket" "s3bucket" {  
  bucket = "${local.name_prefix}-s3.sctp-sandbox.com"

  tags = {
    Name = "${local.name_prefix}-s3.sctp-sandbox.com"
  }

  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "static_site" {
  bucket = aws_s3_bucket.s3bucket.id

  index_document {
    suffix = "index.html"
  }

}

# Allow public access
resource "aws_s3_bucket_public_access_block" "allow_public_access" {
  bucket = aws_s3_bucket.s3bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Add a small delay to ensure the public access block settings are propagated
resource "time_sleep" "wait_for_public_access_block" {
  depends_on = [aws_s3_bucket_public_access_block.allow_public_access]
  create_duration = "10s"
}



resource "aws_s3_bucket_policy" "public_access" {
  bucket = aws_s3_bucket.s3bucket.id
  depends_on = [time_sleep.wait_for_public_access_block]

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "arn:aws:s3:::${aws_s3_bucket.s3bucket.id}/*"
      }
    ]
  })

}

# Create a null resource to trigger the sync
resource "null_resource" "website_sync" {
  # Trigger sync when any of these change
  triggers = {
    bucket_name = aws_s3_bucket.s3bucket.id
    # Add a timestamp to force sync on every apply if needed
    timestamp = timestamp()
  }

  # Use local-exec to run aws s3 sync
  provisioner "local-exec" {
    command = <<-EOT
      echo "Starting website sync to ${aws_s3_bucket.s3bucket.bucket}..."
      aws s3 sync modules/storage/website/ s3://${aws_s3_bucket.s3bucket.bucket}/ --exclude \"*.MD\" --exclude \".git*\"
      if [ $? -eq 0 ]; then
        echo "Website sync completed successfully"
      else
        echo "Website sync failed with exit code $?"
        exit 1
      fi
    EOT
  }

  # Only run after the bucket and all its configurations are created
  depends_on = [
    aws_s3_bucket.s3bucket,
    aws_s3_bucket_website_configuration.static_site,
    aws_s3_bucket_public_access_block.allow_public_access,
    time_sleep.wait_for_public_access_block
  ]
}


/*
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
*/

