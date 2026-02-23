variable "vpc_id" {}
variable "private_subnets" { type = list(string) }
variable "target_group_arn" {}

variable "desired_count" {}
variable "min_capacity" {}
variable "max_capacity" {}