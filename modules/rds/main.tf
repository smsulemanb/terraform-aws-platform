data "aws_secretsmanager_secret_version" "db_secret" {
  secret_id = var.db_secret_arn
}

locals {
  db_creds = jsondecode(data.aws_secretsmanager_secret_version.db_secret.secret_string)
}

resource "aws_db_subnet_group" "db" {
  name       = "aurora-postgres-subnet-group"
  subnet_ids = var.db_subnets
}

resource "aws_security_group" "db_sg" {
  name   = "aurora-db-sg"
  vpc_id = var.vpc_id

  ingress {
    description     = "Allow PostgreSQL from ECS"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.ecs_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_rds_cluster" "aurora" {
  cluster_identifier = "aurora-postgres-cluster"
  engine             = "aurora-postgresql"

  database_name   = var.db_name
  master_username = local.db_creds.username
  master_password = local.db_creds.password

  db_subnet_group_name   = aws_db_subnet_group.db.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  backup_retention_period = 7
  storage_encrypted       = true
  skip_final_snapshot     = true
}

resource "aws_rds_cluster_instance" "instances" {
  count              = 2
  identifier         = "aurora-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.aurora.id
  instance_class     = "db.t3.medium"
  engine             = aws_rds_cluster.aurora.engine
}