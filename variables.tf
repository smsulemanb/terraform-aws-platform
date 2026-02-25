variable "aws_region" {}
variable "environment" {}
variable "cluster_name" {}
variable "service" {}

variable "vpc_cidr" {}
variable "availability_zones" { type = list(string) }

variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "db_subnets" { type = list(string) }

variable "db_name" {}
variable "db_username" {}
variable "db_password" {}

# ECS autoscaling variables
variable "ecs_desired_count" { default = 2 }
variable "ecs_min_count" { default = 2 }
variable "ecs_max_count" { default = 5 }
variable "ecs_cpu_target" { default = 70 }