I have not only fix the code issue but also made it reusbale by adding modules.Moreover, I have extended the code functionality by adding security through adding waf to the alb;cloudwatch for monitoring logs; secrets manager module for adding secrets for db rather than hardcoding them in the code and addding ecs autoscaling.  

Below is the project structure.

terraform-aws-platform/
 ├ main.tf
 ├ variables.tf
 ├ terraform.tfvars
 ├ outputs.tf
 └ modules/
      ├ vpc/
      ├ iam/
      ├ alb/
      ├ waf/
      ├ ecs/
      ├ secrets/
      ├ rds/
      └ cloudwatch/