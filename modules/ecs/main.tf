resource "aws_ecs_cluster" "cluster" {
  name = "platform-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "nginx"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name  = "nginx"
      image = "nginx"
      portMappings = [{
        containerPort = 80
      }]
    }
  ])
}

resource "aws_ecs_service" "service" {
  name            = "nginx-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets = var.private_subnets
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "nginx"
    container_port   = 80
  }
}