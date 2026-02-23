variable "aws_region" {}
variable "project_name" {}
variable "environment" {}

variable "tf_state_bucket" {}
variable "tf_state_key" {}
variable "tf_state_lock_table" {}

variable "vpc_cidr" {}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "domain_name" {}

variable "db_name" {}
variable "db_username" {}

variable "ecs_desired_count" {}
variable "ecs_min_capacity" {}
variable "ecs_max_capacity" {}