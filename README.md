I have not only fix the code issue but also made it reusbale by adding modules.I have extended the code functionality by adding api gateway so that the client requests will come first to the apigateway after going through waf securrity; then go to alb after waf inspection; then from alb to ecs and ecs will access rds database.Moreover, I have also added cloudwatch for monitoring logs; secrets manager module for adding secrets for db rather than hardcoding them in the code and addding ecs autoscaling for cost resource usage efficiency.Please press the code tab in README.md file for better view of the architecture.

Below is the project structure.

terraform-aws-platform/
│
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
│
├── modules/
│
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── iam/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── alb/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── apigateway/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── ecs/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── rds/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── secrets/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── waf/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── cloudwatch/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
     
and Below is the traffic flow:

Internet / Clients
                                   │
                                   │
                        ┌─────────────────────┐
                        │      WAF (Layer 7)  │
                        │  Protects API GW    │
                        └──────────┬──────────┘
                                   │
                                   ▼
                        ┌─────────────────────┐
                        │    API Gateway      │
                        │  (HTTP API)         │
                        └──────────┬──────────┘
                                   │
                                   │ VPC Link
                                   ▼
                 ┌───────────────────────────────────┐
                 │               VPC                 │
                 │          10.0.0.0/16              │
                 │                                   │
                 │  Public Subnets                   │
                 │  ─────────────────────────        │
                 │        ┌────────────────────┐     │
                 │        │   WAF (Regional)   │     │
                 │        │ Protects ALB       │     │
                 │        └─────────┬──────────┘     │
                 │                  │                │
                 │                  ▼                │
                 │        ┌────────────────────┐     │
                 │        │  Application LB    │     │
                 │        │      (ALB)         │     │
                 │        └─────────┬──────────┘     │
                 │                  │                │
                 │                  ▼                │
                 │  Private App Subnets              │
                 │  ─────────────────────────        │
                 │        ┌────────────────────┐     │
                 │        │   ECS Cluster      │     │
                 │        │   Fargate Service  │     │
                 │        │   (Auto Scaling)   │     │
                 │        └─────────┬──────────┘     │
                 │                  │                │
                 │                  ▼                │
                 │  Database Subnets                 │
                 │  ─────────────────────────        │
                 │        ┌────────────────────┐     │
                 │        │ Aurora PostgreSQL  │     │
                 │        │  Multi-AZ Cluster  │     │
                 │        └────────────────────┘     │
                 │                                   │
                 │  Supporting Services              │
                 │  ─────────────────────────        │
                 │   • Secrets Manager (DB creds)    │
                 │   • CloudWatch Logs & Metrics     │
                 │   • NAT Gateway                   │
                 │   • Internet Gateway              │
                 └───────────────────────────────────┘

