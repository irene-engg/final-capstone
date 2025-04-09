resource "aws_security_group" "frontend_alb_sg" {
  name        = "frontend_alb_sg"
  description = "Allow traffic from front end ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
