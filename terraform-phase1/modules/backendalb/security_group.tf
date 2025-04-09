resource "aws_security_group" "backend_alb_sg" {
  name        = "backend_alb_sg"
  description = "Allow traffic from front end ECS"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    
   }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
