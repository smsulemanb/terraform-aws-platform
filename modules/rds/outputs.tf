output "cluster_endpoint" {
  value = aws_rds_cluster.aurora.endpoint
}

output "db_security_group_id" {
  value = aws_security_group.db_sg.id
}