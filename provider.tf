# The default provider configuration
provider "aws" {
  region = var.aws_region        # Dynamically fetch the region from variable

default_tags {
  tags = {
    Environment = "${var.environment}" # Dynamically fetch the environment from variable
    Name        = "${var.name}" # Dynamically fetch the name from variable
    Owner       = "NTU-SCTP-COHORT10"
    Project     = "Modular-AWS"
  }
}
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"  # Use the version you're currently using
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"  # Latest version as of now
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"  # Latest version as of now
    }
  }
}
