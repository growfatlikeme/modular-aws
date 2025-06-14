terraform {
  backend "s3" {
    bucket = "sctp-ce10-tfstate"
    key    = "estee-terraform.tfstate" #The name of the file in the bucket
    region = "ap-southeast-1"  
    dynamodb_table = "estee-terraform-state-lock" # The name of the DynamoDB table for state locking
  }
}
