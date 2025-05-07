# The default provider configuration
provider "aws" {
  region = var.aws_region        # Dynamically fetch the region from variable
}