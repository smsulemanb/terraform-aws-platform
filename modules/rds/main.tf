resource "aws_db_subnet_group" "db" {
  subnet_ids = var.subnets
}

resource "aws_db_instance" "db" {
  engine = "postgres"
  instance_class = "db.t3.micro"
  allocated_storage = 20
  db_name = var.db_name
  username = var.db_username
  manage_master_user_password = true
  multi_az = true
  db_subnet_group_name = aws_db_subnet_group.db.name
}