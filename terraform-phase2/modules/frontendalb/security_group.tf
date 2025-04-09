data "aws_security_group" "frontend_alb_sg" {
  id = tolist(data.aws_lb.frontend_alb.security_groups)[0]  # Convert set to list and get first element
}

resource "aws_security_group_rule" "allow_requests_from_client" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  security_group_id = data.aws_security_group.frontend_alb_sg.id 
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow traffic from everywhere"
}

