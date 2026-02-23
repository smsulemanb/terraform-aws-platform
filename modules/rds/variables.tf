variable "db_name" {}
variable "db_username" {}
variable "db_password_secret_arn" {}
variable "vpc_id" {}
variable "subnets" { type = list(string) }