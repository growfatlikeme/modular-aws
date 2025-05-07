#high level architecture configuration

module "network" {
  source     = "./modules/network"
  myvpc_cidr = var.myvpc_cidr
  name       = var.name
  environment        = var.environment
}