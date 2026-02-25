resource "aws_secretsmanager_secret" "db_secret" {
  name        = var.secret_name
  description = var.description

  recovery_window_in_days = 7

  tags = var.tags
}

# Optional placeholder so Terraform succeeds initially
resource "aws_secretsmanager_secret_version" "placeholder" {
  secret_id = aws_secretsmanager_secret.db_secret.id

  secret_string = jsonencode({
    username = "placeholder"
    password = "placeholder"
  })

  lifecycle {
    ignore_changes = [secret_string]
  }
}