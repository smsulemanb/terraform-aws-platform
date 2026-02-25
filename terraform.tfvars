aws_region  = "eu-west-2"
environment = "test"

cluster_name = "nginx-cluster"
service      = "nginx"

vpc_cidr = "10.0.0.0/16"

availability_zones = [
  "eu-west-2a",
  "eu-west-2b"
]

public_subnets = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnets = [
  "10.0.10.0/24",
  "10.0.11.0/24"
]

db_subnets = [
  "10.0.20.0/24",
  "10.0.21.0/24"
]

db_name = "appdb"

ecs_desired_count = 2
ecs_min_count     = 2
ecs_max_count     = 5
ecs_cpu_target    = 70