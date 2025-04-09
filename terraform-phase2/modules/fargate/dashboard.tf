resource "aws_cloudwatch_dashboard" "ecs_dashboard" {
  dashboard_name = "ecs-monitoring-dashboard"
  
  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/ECS", "CPUUtilization", "ServiceName", aws_ecs_service.frontend_service.name, "ClusterName", var.ecs_cluster_name],
            ["AWS/ECS", "CPUUtilization", "ServiceName", aws_ecs_service.backend_service.name, "ClusterName", var.ecs_cluster_name]
          ]
          view    = "timeSeries"
          stacked = false
          region  = "ca-central-1"
          title   = "ECS Service CPU Utilization"
          period  = 300
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/ECS", "MemoryUtilization", "ServiceName", aws_ecs_service.frontend_service.name, "ClusterName", var.ecs_cluster_name],
            ["AWS/ECS", "MemoryUtilization", "ServiceName", aws_ecs_service.backend_service.name, "ClusterName", var.ecs_cluster_name]
          ]
          view    = "timeSeries"
          stacked = false
          region  = "ca-central-1"
          title   = "ECS Service Memory Utilization"
          period  = 300
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "RequestCount", "TargetGroup", var.target_group_frontend_arn],
          ]
          view    = "timeSeries"
          stacked = false
          region  = "ca-central-1"
          title   = "Frontend Load Balancer Request Count"
          period  = 60
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 6
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "RequestCount", "TargetGroup", var.target_group_backend_arn],
          ]
          view    = "timeSeries"
          stacked = false
          region  = "ca-central-1"
          title   = "Backend Load Balancer Request Count"
          period  = 60
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 12
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "TargetResponseTime", "TargetGroup", var.target_group_frontend_arn],
          ]
          view    = "timeSeries"
          stacked = false
          region  = "ca-central-1"
          title   = "Frontend Response Time"
          period  = 60
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 12
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "TargetResponseTime", "TargetGroup", var.target_group_backend_arn],
          ]
          view    = "timeSeries"
          stacked = false
          region  = "ca-central-1"
          title   = "Backend Response Time"
          period  = 60
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 18
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "HealthyHostCount", "TargetGroup", var.target_group_frontend_arn],
            ["AWS/ApplicationELB", "UnhealthyHostCount", "TargetGroup", var.target_group_frontend_arn]
          ]
          view    = "timeSeries"
          stacked = false
          region  = "ca-central-1"
          title   = "Frontend Target Group Health"
          period  = 60
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 18
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "HealthyHostCount", "TargetGroup", var.target_group_backend_arn],
            ["AWS/ApplicationELB", "UnhealthyHostCount", "TargetGroup", var.target_group_backend_arn]
          ]
          view    = "timeSeries"
          stacked = false
          region  = "ca-central-1"
          title   = "Backend Target Group Health"
          period  = 60
        }
      }
    ]
  })
} 