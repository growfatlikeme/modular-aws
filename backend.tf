terraform {
  backend "s3" {
    bucket = "terraform_state"
    key    = "estee-terraform.tfstate" #Remember to change this
    region = "ap-southeast-1"  #The region of your backend bucket
  }
}
