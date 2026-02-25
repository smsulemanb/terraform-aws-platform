provider "aws" {
  region = var.aws_region
}

# VPC
module "vpc" {
  source             = "./modules/vpc"
  environment        = var.environment
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  db_subnets         = var.db_subnets
}

# IAM roles
module "iam" {
  source = "./modules/iam"
}

# Secrets Manager
module "secrets" {
  source      = "./modules/secrets"
  secret_name = "aurora-postgres-credentials"

  tags = {
    Environment = var.environment
  }
}


# ALB
module "alb" {
  source = "./modules/alb"

  environment    = var.environment
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
}

# WAF
module "waf" {
  source  = "./modules/waf"
  alb_arn = module.alb.alb_arn
}

# ECS
module "ecs" {
  source                 = "./modules/ecs"
  cluster_name           = var.cluster_name
  aws_region             = var.aws_region
  service_name           = var.service
  private_subnets        = module.vpc.private_subnets
  security_group_id      = module.alb.ecs_sg
  target_group_arn       = module.alb.target_group_arn
  task_role_arn          = module.iam.task_role_arn
  execution_role_arn     = module.iam.execution_role_arn
  desired_count          = var.ecs_desired_count
  min_count              = var.ecs_min_count
  max_count              = var.ecs_max_count
  cpu_utilization_target = var.ecs_cpu_target
}

# RDS (Aurora PostgreSQL)
module "rds" {
  source = "./modules/rds"

  db_name               = var.db_name
  vpc_id                = module.vpc.vpc_id
  db_subnets            = module.vpc.db_subnets
  db_secret_arn         = module.secrets.secret_arn
  ecs_security_group_id = module.ecs.ecs_security_group_id
}

# CloudWatch
module "cloudwatch" {
  source = "./modules/cloudwatch"

  cluster_name = var.cluster_name
}