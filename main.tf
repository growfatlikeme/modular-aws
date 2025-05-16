#high level architecture configuration

/*
module "storage" {
  source = "./modules/storage"
  name   = var.name 
  environment = var.environment
}
*/
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
  enable_ssh_key = var.enable_ssh_key
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
  key_name         = module.security.key_pair_name  # Reference the output from the security module
  depends_on       = [module.network, module.security]
}

/*
module "web_app" {
  source = "./modules/web_app"
  name       = var.name
  environment        = var.environment
  instance_type = var.instance_type
  vpc_id = module.network.vpc_id  # Pass VPC ID from network module
  public_subnet_ids = module.network.public_subnet_ids
  sg_web_app_id = module.security.sg_web_app_id  # pass the security group ID from the security module
  key_name         = module.security.key_pair_name  # Reference the output from the security module
  depends_on       = [module.network, module.security]
}*/

module "scaling_web" {
 source = "./modules/scaling_web"
  name       = var.name
  environment        = var.environment
  instance_type = var.instance_type
  vpc_id = module.network.vpc_id  # Pass VPC ID from network module
  public_subnet_ids = module.network.public_subnet_ids
  private_subnet_ids =  module.network.private_subnet_ids
  alb_sg_id = module.security.alb_sg_id  # pass the security group ID from the security module
  sg_web_app_id = module.security.sg_web_app_id  # pass the security group ID from the security module
  sg_ssh_priv_from_bastion_id = module.security.web_app_allow_ssh_from_bastion_id  # pass the security group ID from the security module
  key_name         = module.security.private_key_name  # Reference the output from the security module
  depends_on       = [module.network, module.security]
}

/*
module "app_topics" {
 source      = "./modules/app_topics"
  name       = var.name
  environment        = var.environment
  cart_count = var.cart_count
}
*/
