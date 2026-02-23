Project Structure

terraform-aws-platform
│
├── backend.tf
├── provider.tf
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
│
└── modules
    ├── vpc
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    ├── alb
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    ├── ecs
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    ├── rds
    │   ├── main.tf
    │   └── variables.tf
    │
    ├── secrets
    │   ├── main.tf
    │   └── variables.tf
    │
    ├── waf
    │   ├── main.tf
    │   └── variables.tf
    │
    └── monitoring
        ├── main.tf
        └── variables.tf
