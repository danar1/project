resource "aws_lb" "kibana" {
  name                       = "kibana-alb"
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = var.subnet_ids
  security_groups            = [aws_security_group.kibana-lb-sg.id]

  tags = merge(var.tags, map("Name", "kibana-alb"))
}


resource "aws_lb_listener" "kibana" {
  load_balancer_arn = aws_lb.kibana.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.kibana.arn
  }
}

resource "aws_lb_target_group" "kibana" {
  name     = "kibana-target-group"
  port     = 5601
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled = true
    path    = "/app/home"
  }

  tags = merge(var.tags, map("Name", "kibana-target-group"))
}

resource "aws_lb_target_group_attachment" "grafakibanana" {
  target_group_arn = aws_lb_target_group.kibana.id
  target_id        = aws_instance.kibana.id
  port             = 5601
}