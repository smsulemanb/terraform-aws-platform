module "vpc" {
  source = "./modules/vpc"

  project_name   = var.project_name
  vpc_cidr       = var.vpc_cidr
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
}

module "secrets" {
  source = "./modules/secrets"
  project_name = var.project_name
}

module "rds" {
  source = "./modules/rds"

  db_name  = var.db_name
  db_username = var.db_username
  db_password_secret_arn = module.secrets.db_secret_arn
  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.private_subnets
}

module "alb" {
  source = "./modules/alb"

  vpc_id = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  domain_name = var.domain_name
}

module "ecs" {
  source = "./modules/ecs"

  vpc_id = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  target_group_arn = module.alb.target_group_arn

  desired_count = var.ecs_desired_count
  min_capacity  = var.ecs_min_capacity
  max_capacity  = var.ecs_max_capacity
}

module "waf" {
  source = "./modules/waf"
  alb_arn = module.alb.alb_arn
}

module "monitoring" {
  source = "./modules/monitoring"
  cluster_name = module.ecs.cluster_name
}