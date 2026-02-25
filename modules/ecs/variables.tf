variable "cluster_name" {}
variable "service_name" {}
variable "private_subnets" { type = list(string) }
variable "security_group_id" {}
variable "target_group_arn" {}
variable "task_role_arn" {}
variable "execution_role_arn" {}
variable "aws_region" {}
variable "desired_count" { default = 2 }
variable "min_count" { default = 2 }
variable "max_count" { default = 5 }
variable "cpu_utilization_target" { default = 70 }