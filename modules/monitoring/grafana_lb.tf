resource "aws_lb" "grafana" {
  name                       = "grafana-alb"
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = var.private_subnets
  security_groups            = [aws_security_group.grafana-lb-sg.id]

  tags = merge(var.tags, map("Name", "grafana-alb"))
}


resource "aws_lb_listener" "grafana" {
  load_balancer_arn = aws_lb.grafana.arn
  port              = 3000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.grafana.arn
  }
}

resource "aws_lb_target_group" "grafana" {
  name     = "grafana-target-group"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled = true
    path    = "/"
  }

  tags = merge(var.tags, map("Name", "grafana-target-group"))
}

resource "aws_lb_target_group_attachment" "grafana" {
  target_group_arn = aws_lb_target_group.grafana.id
  target_id        = aws_instance.grafana.id
  port             = 3000
}