variable "secret_name" {
  description = "Name of the database secret"
  type        = string
}

variable "description" {
  description = "Description of the secret"
  type        = string
  default     = "Database credentials"
}

variable "tags" {
  type    = map(string)
  default = {}
}