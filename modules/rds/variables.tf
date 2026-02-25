variable "db_name" {}
variable "vpc_id" {}
variable "db_subnets" { type = list(string) }
variable "db_secret_arn" {}
variable "ecs_security_group_id" {}