#high level architecture configuration

module "network" {
  source     = "./modules/network"
  myvpc_cidr = var.myvpc_cidr
  name       = var.name
  environment        = var.environment

  aws_region = var.aws_region
  azs       = var.azs
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs

}