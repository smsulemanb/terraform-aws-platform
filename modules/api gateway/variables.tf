variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "alb_listener_arn" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}