variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where ALB will be deployed"
  type        = string
}

variable "public_subnets" {
  description = "Public subnet IDs for ALB"
  type        = list(string)
}

variable "alb_port" {
  description = "ALB listener port"
  type        = number
  default     = 80
}

variable "target_port" {
  description = "Target group port"
  type        = number
  default     = 80
}

variable "enable_deletion_protection" {
  description = "Enable ALB deletion protection"
  type        = bool
  default     = false
}

variable "health_check_path" {
  description = "Health check path"
  type        = string
  default     = "/"
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}