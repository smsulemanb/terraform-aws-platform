output "alb_dns" {
  value = module.alb.alb_dns
}

output "rds_endpoint" {
  value = module.rds.cluster_endpoint
}

output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}