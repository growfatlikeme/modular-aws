

resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "estee-terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "${local.name_prefix}-tfstate-lock"
  }

 stream_enabled = true
 stream_view_type = "NEW_AND_OLD_IMAGES"  # Change to "NEW_IMAGE" or "OLD_IMAGE" for different stream view types

}

