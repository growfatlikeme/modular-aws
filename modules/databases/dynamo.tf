resource "aws_dynamodb_table" "groceries" {
  name         = "${local.name_prefix}-dynamodb-groceries"
  billing_mode = "PAY_PER_REQUEST"  # On-demand scaling

  attribute {
    name = "productid"
    type = "S"  # 'S' = String, or use 'N' for Number
  }

  attribute {
    name = "supplier"
    type = "S"
  }

  # Define primary keys (Partition + Sort Key)
  hash_key  = "productid"  # Partition Key
  range_key = "supplier"   # Sort Key



  tags = {
    Name = "${local.name_prefix}-dynamodb-groceries"
  }

}