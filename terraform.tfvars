aws_region = "eu-west-2"
project_name = "platform"
environment = "prod"

tf_state_bucket = "terraform-platform-state"
tf_state_key = "infra/terraform.tfstate"
tf_state_lock_table = "terraform-lock"

vpc_cidr = "10.0.0.0/16"

public_subnets = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnets = [
  "10.0.10.0/24",
  "10.0.11.0/24"
]

domain_name = "example.com"

db_name = "appdb"
db_username = "admin"

ecs_desired_count = 2
ecs_min_capacity = 2
ecs_max_capacity = 5