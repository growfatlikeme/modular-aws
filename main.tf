#high level architecture configuration

module "storage" {
  source = "./modules/storage"
  name   = var.name 
  environment = var.environment
}

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

module "security" {
  source       = "./modules/security"
  name         = var.name
  environment  = var.environment
  vpc_id       = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_subnet_ids
}

module "compute" {
  source     = "./modules/compute"
  name       = var.name
  environment        = var.environment
  vpc_id = module.network.vpc_id  # Pass VPC ID from network module
  instance_type = var.instance_type
  sg_bastion_id = module.security.sg_bastion_id  # Match the exact output name
  public_subnet_ids = module.network.public_subnet_ids
  depends_on   = [module.network, module.security]
}


