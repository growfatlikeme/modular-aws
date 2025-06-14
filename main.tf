#high level architecture configuration


module "storage" {
  source = "./modules/storage"
  name   = var.name 
  environment = var.environment
  
}

/*
module "databases" {
  source     = "./modules/databases"
  name       = var.name
  environment        = var.environment
  database_subnet_group_name = module.network.database_subnet_group_name  # Use the subnet group from the network module
  rds_sg_id = [module.security.rds_sg_id]  # pass the security group ID from the security module
  region = var.aws_region
}*/

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

module "iam" {            #policies and roles defined here
  source       = "./modules/iam"
  name         = var.name
  environment  = var.environment

}

/*
module "compute" {          #this is the bastion host module
  source     = "./modules/compute"
  name       = var.name
  environment        = var.environment
  vpc_id = module.network.vpc_id  # Pass VPC ID from network module
  instance_type = var.instance_type
  sg_bastion_id = module.security.sg_bastion_id  # Match the exact output name
  public_subnet_ids = module.network.public_subnet_ids
  key_name         = module.security.key_pair_name  # Reference the output from the security module
  instance_profile_name = module.iam.instance_profile_name  # Reference the output from the security module
  depends_on       = [module.network, module.security]
}
*/

module "web_app" {
  source = "./modules/web_app"
  name       = var.name
  environment        = var.environment
  instance_type = var.instance_type
  region = var.aws_region
  vpc_id = module.network.vpc_id  # Pass VPC ID from network module
  public_subnet_ids = module.network.public_subnet_ids
  sg_bastion_id    = module.security.sg_bastion_id  # pass the security group ID from the security module to allow ssh access
  key_name         = module.security.key_pair_name  # Reference the output from the security module
  depends_on       = [module.network, module.security]
}

/*
module "ebs" {
  source = "./modules/ebs"
  name       = var.name
  environment        = var.environment
  azs       = module.web_app.ec2_public_instance_availability_zone
  instance_ids = module.web_app.ec2_public_instance_id
 // sg_web_app_id = module.security.sg_web_app_id  # pass the security group ID from the security module
  
  depends_on       = [module.web_app]
}
*/

module "scaling_web" {
 source = "./modules/scaling_web"
  name       = var.name
  environment        = var.environment
  #for launch template, ASG, Load Balancer, and Target Group
  instance_type = var.instance_type
  vpc_id = module.network.vpc_id  # Pass VPC ID from network module
  public_subnet_ids = module.network.public_subnet_ids
  private_subnet_ids =  module.network.private_subnet_ids
  alb_sg_id = module.security.alb_sg_id  # pass the security group ID from the security module
  sg_web_app_id = module.security.sg_web_app_id  # pass the security group ID from the security module
  sg_ssh_priv_from_bastion_id = module.security.web_app_allow_ssh_from_bastion_id  # pass the security group ID from the security module
  key_name         = module.security.private_key_name  # Reference the output from the security module
  base_domain = "scaling-web.com"  # Domain name for the certificate
  
  #for bucket Route53 configuration
  hosted_zone_id = module.storage.tf_bucket_hosted_zone_id  # Use the hosted zone ID from the storage module
  website_configuration_domain = module.storage.website_configuration_domain  # Use the domain from the storage module
  
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
