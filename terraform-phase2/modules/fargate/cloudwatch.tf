# CloudWatch Alarms for ECS Services

# Frontend CPU Utilization Alarm
resource "aws_cloudwatch_metric_alarm" "frontend_cpu_high" {
  alarm_name          = "frontend-cpu-utilization-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors frontend ECS CPU utilization"
  actions_enabled     = true

  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = aws_ecs_service.frontend_service.name
  }
}

# Frontend Memory Utilization Alarm
resource "aws_cloudwatch_metric_alarm" "frontend_memory_high" {
  alarm_name          = "frontend-memory-utilization-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors frontend ECS memory utilization"
  actions_enabled     = true

  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = aws_ecs_service.frontend_service.name
  }
}

# Backend CPU Utilization Alarm
resource "aws_cloudwatch_metric_alarm" "backend_cpu_high" {
  alarm_name          = "backend-cpu-utilization-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors backend ECS CPU utilization"
  actions_enabled     = true

  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = aws_ecs_service.backend_service.name
  }
}

# Backend Memory Utilization Alarm
resource "aws_cloudwatch_metric_alarm" "backend_memory_high" {
  alarm_name          = "backend-memory-utilization-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors backend ECS memory utilization"
  actions_enabled     = true

  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = aws_ecs_service.backend_service.name
  }
}

# Service Health Alarms

# Frontend Service Health Alarm
resource "aws_cloudwatch_metric_alarm" "frontend_service_health" {
  alarm_name          = "frontend-service-health"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Minimum"
  threshold           = 1
  alarm_description   = "This metric monitors frontend ECS task health"
  actions_enabled     = true

  dimensions = {
    TargetGroup = var.target_group_frontend_arn
  }
}

# Backend Service Health Alarm
resource "aws_cloudwatch_metric_alarm" "backend_service_health" {
  alarm_name          = "backend-service-health"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Minimum"
  threshold           = 1
  alarm_description   = "This metric monitors backend ECS task health"
  actions_enabled     = true

  dimensions = {
    TargetGroup = var.target_group_backend_arn
  }
} 