resource "random_password" "db" {
  length  = 16
  special = true
}

resource "aws_secretsmanager_secret" "db_secret" {
  name = "${var.project_name}-db-secret"
}

resource "aws_secretsmanager_secret_version" "db_secret_value" {
  secret_id = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    password = random_password.db.result
  })
}

output "db_secret_arn" {
  value = aws_secretsmanager_secret.db_secret.arn
}