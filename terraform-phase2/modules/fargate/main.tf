# Remove the ECS cluster creation since we're using an existing one
# resource "aws_ecs_cluster" "cloud_cluster" {
#   name = "cloud-cluster"
# }

resource "aws_ecs_task_definition" "frontend_task" {
  family                   = "frontend-task"
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "frontend-container"
      image     = "docker.io/ireneengg2011/irene-frontend:latest"
      cpu       = 256
      memory    = 512
      essential = true
      environment = [
        {
          name  = "BACKEND_URL"
          value = "http://${var.backend_alb_dns}:5000"
        }
      ]
      portMappings = [
        {
        containerPort = 80  # Expose port 80 for ALB to route traffic
        hostPort      = 80  # Use hostPort 80 as well
        protocol      = "tcp"
      }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.frontend_log_group.name
          "awslogs-region"        = "ca-central-1"
          "awslogs-stream-prefix" = "frontend"
        }
      }
    }
  ])
}

resource "aws_cloudwatch_log_group" "frontend_log_group" {
  name              = "/ecs/frontend-task"
  retention_in_days = 14
  tags = {
    Application = "frontend"
    Environment = "production"
  }
}

resource "aws_ecs_task_definition" "backend_task" {
  family                   = "backend-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "backend-container"
      image     = "docker.io/ireneengg2011/irene-backend:latest"
      cpu       = 256
      memory    = 512
      essential = true
      environment = var.backend_env_vars
      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.backend_log_group.name
          "awslogs-region"        = "ca-central-1"
          "awslogs-stream-prefix" = "backend"
        }
      }
    }
  ])
}

resource "aws_cloudwatch_log_group" "backend_log_group" {
  name              = "/ecs/backend-task"
  retention_in_days = 14
  tags = {
    Application = "backend"
    Environment = "production"
  }
}

resource "aws_ecs_service" "frontend_service" {
  name            = "frontend-service"
  cluster         = var.ecs_cluster_name
  task_definition = aws_ecs_task_definition.frontend_task.arn
  launch_type     = "FARGATE"
  desired_count   = 2

  load_balancer {
    target_group_arn = var.target_group_frontend_arn
    container_name   = "frontend-container"
    container_port   = 80
  }

  network_configuration {
    subnets         = [var.frontend_subnet1, var.frontend_subnet2]  # Use both subnets
    security_groups = [aws_security_group.frontend_sg.id]
    assign_public_ip = false
  }

  }

resource "aws_ecs_service" "backend_service" {
  name            = "backend-service"
  cluster         = var.ecs_cluster_name
  task_definition = aws_ecs_task_definition.backend_task.arn
  launch_type     = "FARGATE"
  desired_count   = 2

  load_balancer {
    target_group_arn = var.target_group_backend_arn
    container_name   = "backend-container"
    container_port   = 5000
  }
  depends_on = [
    var.backend_listener_id,
    var.target_group_backend_arn]
  

  network_configuration {
    subnets         = [var.backend_subnet1, var.backend_subnet2]  # Use both subnets
    security_groups = [aws_security_group.backend_sg.id]
    assign_public_ip = false
  }
}
