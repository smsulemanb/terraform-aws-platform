output "cluster_name" {
  value = aws_ecs_cluster.cluster.name
}

output "service_name" {
  value = aws_ecs_service.service.name
}

output "ecs_autoscaling_target" {
  value = aws_appautoscaling_target.ecs.id
}