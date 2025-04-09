data "aws_security_group" "backend_alb_sg" {
  id = tolist(data.aws_lb.backend_alb.security_groups)[0]  # Convert set to list and get first element
}

resource "aws_security_group_rule" "allow_frontend_to_backend" {
  type                     = "ingress"
  from_port                = 5000
  to_port                  = 5000
  protocol                 = "TCP"
  security_group_id        = data.aws_security_group.backend_alb_sg.id  # Backend ALB SG
  source_security_group_id = var.frontend_ecs_sg_id  # Frontend ECS SG
  description              = "Allow traffic from frontend ECS cluster to backend ALB"
}

