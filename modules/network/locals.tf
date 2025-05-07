#An expression to be used multiple times within a module.
/*
locals {
  env_name      = var.environment
  owner         = var.name

  region = var.aws_region
  azs = var.azs

  vpc_cidr = var.myvpc_cidr
  pub_subnet_cidrs = var.public_subnet_cidrs
  priv_subnet_cidrs = var.private_subnet_cidrs   
  db_subnet_cidrs = var.database_subnet_cidrs

  #ec2_size      = var.instance_type

  tagging = "${local.owner}-${local.env_name}-"

}
*/

locals {
  name_prefix = "${var.name}-${var.environment}"
}
