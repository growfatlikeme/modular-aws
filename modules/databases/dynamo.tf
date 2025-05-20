resource "aws_dynamodb_table" "dynamodb" {
  name         = "${local.name_prefix}-dynamodb-books"
  billing_mode = "PAY_PER_REQUEST"

  # Define primary keys (Partition + Sort Key)
  hash_key     = "ISBN"
  range_key    = "Genre"

  attribute {
    name = "ISBN"
    type = "S"
  }

  attribute {
    name = "Genre"
    type = "S"
  }

  provisioner "local-exec" {
    command = "modules/databases/sampledata.sh \"${local.name_prefix}-dynamodb-books\" \"${var.region}\""
    //working_dir = "${path.module}"
  }

  tags = {
    Name = "${local.name_prefix}-dynamodb-books"
  }
}
